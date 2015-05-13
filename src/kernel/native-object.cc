// Copyright 2014 Runtime.JS project authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "native-object.h"
#include <kernel/x64/io-x64.h>
#include <kernel/acpi-manager.h>
#include <kernel/utils.h>
#include <kernel/v8utils.h>
#include <memory>
#include <accommon.h>
#include <acpi.h>
#include <kernel/engines.h>
#include <kernel/platform.h>
#include <kernel/version.h>
#include <kernel/arraybuffer.h>

namespace rt {

template<typename T>
using SharedSTLVector = std::vector<T, DefaultSTLAlloc<T>>;

NATIVE_FUNCTION(NativesObject, StartProfiling) {
    PROLOGUE_NOTHIS;
#ifdef RUNTIME_PROFILER
    printf("[PROFILER] started");
    GLOBAL_platform()->profiler().Enable();
#endif
}

NATIVE_FUNCTION(NativesObject, StopProfiling) {
    PROLOGUE_NOTHIS;
#ifdef RUNTIME_PROFILER
    printf("[PROFILER] stopped");
    GLOBAL_platform()->profiler().Disable();
#endif
}

NATIVE_FUNCTION(NativesObject, GetCommandLine) {
    PROLOGUE_NOTHIS;
    printf("[PROFILER] started");
    auto cmd = GLOBAL_platform()->GetCommandLine();
    args.GetReturnValue().Set(v8::String::NewFromUtf8(iv8, cmd.c_str()));
}


uint16_t swap16(uint16_t x) {
    return x << 8 | x >> 8;
}

uint16_t ComputeChecksum(uint32_t start_with, const uint8_t* buffer, size_t length) {
    uint32_t i;
    uint32_t sum = start_with;

    for (i = 0; i < (length & ~1U); i += 2) {
        sum += (uint16_t)swap16(*((uint16_t *)(buffer + i)));
    }

    if (i < length) {
        sum += buffer[i] << 8;
    }

    sum = (sum & 0xffff) + (sum >> 16);
    sum += (sum >> 16);
    return ~sum & 0xffff;
}

NATIVE_FUNCTION(NativesObject, NetChecksum) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    USEARG(1);
    USEARG(2);
    USEARG(3);
    VALIDATEARG(0, ARRAYBUFFER, "argument 0 is not an ArrayBuffer");
    VALIDATEARG(1, UINT32, "argument 1 is not a Uint32");
    VALIDATEARG(2, UINT32, "argument 2 is not a Uint32");
    VALIDATEARG(3, UINT32, "argument 3 is not a Uint32");
    RT_ASSERT(arg0->IsArrayBuffer());
    auto abv8 = arg0.As<v8::ArrayBuffer>();
    if (0 == abv8->ByteLength()) {
        THROW_ERROR("ArrayBuffer should not be empty");
    }

    auto ab = ArrayBuffer::FromInstance(iv8, abv8);
    uint32_t offset = arg1->Uint32Value();
    uint32_t len = arg2->Uint32Value();
    uint32_t extra = arg3->Uint32Value();

    if (offset + len > ab->size()) {
        THROW_ERROR("incorrect buffer offset/length");
    }

    uint16_t ck = ComputeChecksum(extra, reinterpret_cast<uint8_t*>(ab->data()) + offset, len);
    args.GetReturnValue().Set(v8::Uint32::NewFromUnsigned(iv8, ck));
}

NATIVE_FUNCTION(NativesObject, HandleMethodCall) {
    PROLOGUE_NOTHIS;
    RuntimeStateScope<RuntimeState::HANDLE_CALL> handle_call_state(th->thread_manager());

    if (args.IsConstructCall()) {
        THROW_ERROR("function is not a constructor");
    }

    auto thisvalue = args.This();
    if (thisvalue.IsEmpty() || !thisvalue->IsObject()) {
        THROW_ERROR("illegal invocation");
    }

    auto obj = thisvalue->ToObject();
    if (obj->InternalFieldCount() != 1) {
        THROW_ERROR("illegal invocation");
    }

    void* ptr = obj->GetAlignedPointerFromInternalField(0);
    HandleObject* handle_object { static_cast<HandleObject*>(ptr) };
    RT_ASSERT(handle_object);

    if (NativeTypeId::TYPEID_HANDLE != handle_object->type_id()) {
        THROW_ERROR("object is not a handle");
    }

    auto function_data = args.Data();
    RT_ASSERT(function_data->IsExternal());
    uint64_t pack = reinterpret_cast<uint64_t>(function_data.As<v8::External>()->Value());
    uint32_t pool_index = static_cast<uint32_t>(pack >> 32);
    uint32_t method_index = static_cast<uint32_t>(pack);
    uint32_t handle_id = handle_object->handle_id();

    if (handle_object->pool_id() != pool_index) {
        THROW_ERROR("handle does not support this method");
    }

    TransportData data;
    {	TransportData::SerializeError err { data.MoveArgs(th, args) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    HandlePool* pool = GLOBAL_engines()->handle_pools().GetPoolById(handle_object->pool_id());
    RT_ASSERT(pool);

    v8::Local<v8::Promise::Resolver> promise_resolver;
    {   RuntimeStateScope<RuntimeState::PROMISE_NATIVE_API> promise_scope(th->thread_manager());
        promise_resolver = v8::Promise::Resolver::New(iv8);
    }

    uint32_t promise_index = th->AddPromise(
        v8::UniquePersistent<v8::Promise::Resolver>(iv8, promise_resolver));

    {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
            ThreadMessage::Type::HANDLE_METHOD_CALL,
            th->handle(), std::move(data), handle_object->wpipe(),
            promise_index, pack, handle_id, handle_object->rpipe()));
        pool->thread_handle().getUnsafe()->PushMessage(std::move(msg));
    }

    args.GetReturnValue().Set(promise_resolver);
}

NATIVE_FUNCTION(NativesObject, CallHandler) {
    PROLOGUE_NOTHIS;
    RuntimeStateScope<RuntimeState::RPC_CALL> rpc_call_state(th->thread_manager());

    if (args.IsConstructCall()) {
        THROW_ERROR("function is not a constructor");
    }

    v8::Local<v8::Value> thisvalue { args.This() };
    RT_ASSERT(!thisvalue.IsEmpty());
    if (!thisvalue->IsObject()) return;

    v8::Local<v8::Object> obj { thisvalue->ToObject() };
    if (obj->InternalFieldCount() != 1) return;
    void* ptr = obj->GetAlignedPointerFromInternalField(0);
    if (nullptr == ptr) return;

    ExternalFunction* efn { static_cast<ExternalFunction*>(ptr) };
    RT_ASSERT(efn);

    TransportData data;
    {	TransportData::SerializeError err { data.MoveArgs(th, args) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    v8::Local<v8::Promise::Resolver> promise_resolver;
    {   RuntimeStateScope<RuntimeState::PROMISE_NATIVE_API> promise_scope(th->thread_manager());
        promise_resolver = v8::Promise::Resolver::New(iv8);
    }

    uint32_t promise_index = th->AddPromise(
        v8::UniquePersistent<v8::Promise::Resolver>(iv8, promise_resolver));

    {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
            ThreadMessage::Type::FUNCTION_CALL,
            th->handle(),
            std::move(data), efn, promise_index));
        efn->recv().getUnsafe()->PushMessage(std::move(msg));
    }

    args.GetReturnValue().Set(promise_resolver);
}

NATIVE_FUNCTION(NativesObject, TextEncoderEncode) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    v8::Local<v8::String> str = arg0->ToString();
    int len = str->Utf8Length();
    RT_ASSERT(len >= 0);

    size_t buf_len = len;
    auto options = v8::String::WriteOptions::NO_NULL_TERMINATION;

    char* data = nullptr;
    if (0 != buf_len) {
        data = new char[buf_len];
        str->WriteUtf8(data, buf_len, nullptr, options);
    }

    auto abv8 = ArrayBuffer::FromBuffer(iv8, data, buf_len)->GetInstance();
    args.GetReturnValue().Set(v8::Uint8Array::New(abv8, 0, abv8->ByteLength()));
}

NATIVE_FUNCTION(NativesObject, TextDecoderDecode) {
    PROLOGUE_NOTHIS;
    USEARG(0);

    v8::Local<v8::ArrayBuffer> abv8;
    if (arg0->IsUint8Array()) {
        auto abviewv8 = arg0.As<v8::ArrayBufferView>();
        abv8 = abviewv8->Buffer();
    } else if (arg0->IsArrayBuffer()) {
        abv8 = arg0.As<v8::ArrayBuffer>();
    }

    if (abv8.IsEmpty()) {
        THROW_ERROR("argument 0 is not an ArrayBuffer or Uint8Array");
    }

    RT_ASSERT(!abv8.IsEmpty());
    RT_ASSERT(abv8->IsArrayBuffer());

    if (0 == abv8->ByteLength()) {
        args.GetReturnValue().SetEmptyString();
        return;
    }

    auto ab = ArrayBuffer::FromInstance(iv8, abv8);
    args.GetReturnValue().Set(v8::String::NewFromUtf8(iv8,
        reinterpret_cast<const char*>(ab->data()), v8::String::kNormalString, ab->size()));
}

NATIVE_FUNCTION(NativesObject, TextEncoder) {
    PROLOGUE_NOTHIS;

    if (!args.IsConstructCall()) {
        THROW_ERROR("constructor cannot be called as a function");
    }

    // TODO: add other encodings
    LOCAL_V8STRING(s_encoding, "encoding");
    LOCAL_V8STRING(s_utf8, "utf-8");
    args.This()->Set(s_encoding, s_utf8);
}

NATIVE_FUNCTION(NativesObject, TextDecoder) {
    PROLOGUE_NOTHIS;

    if (!args.IsConstructCall()) {
        THROW_ERROR("constructor cannot be called as a function");
    }

    // TODO: add other encodings
    LOCAL_V8STRING(s_encoding, "encoding");
    LOCAL_V8STRING(s_utf8, "utf-8");
    args.This()->Set(s_encoding, s_utf8);
}

NATIVE_FUNCTION(NativesObject, SyncRPC) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    VALIDATEARG(0, PROMISE, "sync: argument 0 is not a promise");

    Nullable<uint32_t> pr = th->FindPromise(arg0.As<v8::Promise::Resolver>());
    if (pr.empty()) {
        THROW_ERROR("sync: promise is not attached to RPC call");
    }

    uint32_t promise_id = pr.get();
    std::unique_ptr<ThreadMessage> message { nullptr };
    do {
        message = th->handle().getUnsafe()
            ->TakePromiseResultMessage(promise_id);

        if (nullptr != message) {
            break;
        }

        Cpu::WaitPause();
        RT_ASSERT(th->thread_manager());
        th->thread_manager()->Preempt();
    } while (true);

    RT_ASSERT(message);
    RT_ASSERT(promise_id == message->recv_index());
    v8::Local<v8::Value> unpacked { message->data().Unpack(th) };
    RT_ASSERT(!unpacked.IsEmpty());

    th->TakePromise(message->recv_index());

    if (ThreadMessage::Type::FUNCTION_RETURN_RESOLVE == message->type()) {
        args.GetReturnValue().Set(unpacked); // Return value directly
    } else {
        iv8->ThrowException(unpacked); // Throw an error
    }
}

NATIVE_FUNCTION(NativesObject, CallResult) {
    PROLOGUE_NOTHIS;
    RT_ASSERT(4 == args.Length());
    USEARG(0);
    USEARG(1);
    USEARG(2);
    USEARG(3);
    RT_ASSERT(arg0->IsBoolean());
    RT_ASSERT(arg1->IsExternal());
    RT_ASSERT(arg2->IsUint32());

    v8::Local<v8::External> ext { v8::Local<v8::External>::Cast(arg1) };
    void* val { ext->Value() };
    RT_ASSERT(val);
    ResourceHandle<EngineThread> thread(static_cast<EngineThread*>(val));

    TransportData data;
    {	TransportData::SerializeError err { data.MoveValue(th, arg3) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
            arg0->BooleanValue() ?
                ThreadMessage::Type::FUNCTION_RETURN_RESOLVE :
                ThreadMessage::Type::FUNCTION_RETURN_REJECT,
            th->handle(),
            std::move(data), nullptr, arg2->Uint32Value()));
        thread.getUnsafe()->PushMessage(std::move(msg));
    }
}

NATIVE_FUNCTION(NativesObject, ClearTimer) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    args.GetReturnValue().Set(v8::Boolean::New(iv8,
        th->FlagTimeoutCleared(arg0->Uint32Value())));
}

uint32_t SetTimer(v8::Isolate* iv8, Thread* th,
                  v8::Local<v8::Value> cb, uint32_t delay, bool autoreset) {
    RT_ASSERT(iv8);
    RT_ASSERT(th);
    RT_ASSERT(!cb.IsEmpty());
    RT_ASSERT(cb->IsFunction());
    uint32_t index = th->AddTimeoutData(
        TimeoutData(v8::UniquePersistent<v8::Value>(iv8, cb), delay, autoreset));

    RT_ASSERT(th->thread_manager());
    th->thread_manager()->SetTimeout(th, index, delay);
    return index;
}

NATIVE_FUNCTION(NativesObject, SetTimeout) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, FUNCTION, "setTimeout: argument 0 is not a function");
    args.GetReturnValue().Set(v8::Uint32::NewFromUnsigned(iv8,
        SetTimer(iv8, th, arg0, arg1->Uint32Value(), false)));
}

NATIVE_FUNCTION(NativesObject, SetInterval) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, FUNCTION, "setInterval: argument 0 is not a function");
    args.GetReturnValue().Set(v8::Uint32::NewFromUnsigned(iv8,
        SetTimer(iv8, th, arg0, arg1->Uint32Value(), true)));
}

NATIVE_FUNCTION(NativesObject, KernelLog) {
    int argc = args.Length();
    for (int i = 0; i < argc; ++i) {
        v8::Local<v8::Value> v = args[i];
        v8::Local<v8::String> s = v->ToString();

        uint32_t len = s->Length();

        uint8_t* buf = new uint8_t[len+1];
        s->WriteOneByte(buf, 0);
        printf("%s", buf);
        delete[] buf;

        if (i != argc - 1) {
            printf(" ");
        }
    }
    printf("\n");
    args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(NativesObject, InitrdText) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    VALIDATEARG(0, STRING, "initrdText: argument 0 is not a string");

    v8::Local<v8::String> filename = arg0->ToString();
    v8::String::Utf8Value filename_utf8(filename);
    const char* filename_buf = *filename_utf8;
    RT_ASSERT(filename_buf);

    InitrdFile file = GLOBAL_initrd()->Get(filename_buf);
    if (file.IsEmpty()) {
        printf("required file not found '%s'\n", filename_buf);
        RT_ASSERT(!"not found");
        args.GetReturnValue().SetNull();
        return;
    }

    v8::Local<v8::String> text { v8::String::NewFromUtf8(iv8,
        reinterpret_cast<const char*>(file.Data()),
        v8::String::kNormalString, file.Size()) };

    args.GetReturnValue().Set(text);
}

NATIVE_FUNCTION(NativesObject, InitrdList) {
    PROLOGUE_NOTHIS;
    size_t files_count { GLOBAL_initrd()->files_count() };
    v8::Local<v8::Array> arr { v8::Array::New(iv8, files_count) };

    LOCAL_V8STRING(s_name, "name");
    LOCAL_V8STRING(s_size, "size");

    v8::Local<v8::Object> tmp { v8::Object::New(iv8) };
    tmp->Set(s_name, v8::String::Empty(iv8));
    tmp->Set(s_size, v8::Uint32::NewFromUnsigned(iv8, 0));

    for (size_t i = 0; i < files_count; ++i) {
        InitrdFile file = GLOBAL_initrd()->GetByIndex(i);
        RT_ASSERT(!file.IsEmpty());

        RT_ASSERT(file.Size() < 0xffffffff && "Initrd file is too big");
        v8::Local<v8::Object> file_object { tmp->Clone() };
        file_object->Set(s_name, v8::String::NewFromUtf8(iv8, file.Name()));
        file_object->Set(s_size, v8::Uint32::NewFromUnsigned(iv8, file.Size() & 0xffffffff));
        arr->Set(i, file_object);
    }

    args.GetReturnValue().Set(arr);
}

NATIVE_FUNCTION(NativesObject, KernelLoaderCallback) {
    PROLOGUE_NOTHIS;
    USEARG(0);

    v8::String::Utf8Value filename_utf8(arg0->ToString());
    const char* filename_buf = *filename_utf8;
    RT_ASSERT(filename_buf);

    InitrdFile file = GLOBAL_initrd()->Get(filename_buf);
    if (file.IsEmpty()) {
        THROW_ERROR("Unable to load requested file");
        return;
    }

    {   TransportData data;
        data.SetEvalData(file.Data(), file.Size(), filename_buf);

        std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
            ThreadMessage::Type::EVALUATE,
            th->handle(),
            std::move(data)));
        th->handle().get()->PushMessage(std::move(msg));
    }

    th->Ref();
    args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(NativesObject, SystemInfo) {
    PROLOGUE_NOTHIS;
    USEARG(0);

    auto obj = v8::Object::New(iv8);

    // TODO: add other counters
    {   auto counters = v8::Array::New(iv8, 1);
        auto ticks = static_cast<uint32_t>(th->thread_manager()->ticks_count());
        counters->Set(0, v8::Uint32::NewFromUnsigned(iv8, ticks));
        LOCAL_V8STRING(s_irq_counters, "irqCounters");
        obj->Set(s_irq_counters, counters);
    }

    {   auto ev_count = static_cast<uint32_t>(th->thread_manager()->events_count());
        LOCAL_V8STRING(s_events_count, "eventsCount");
        obj->Set(s_events_count, v8::Uint32::NewFromUnsigned(iv8, ev_count));
    }

    args.GetReturnValue().Set(obj);
}

NATIVE_FUNCTION(NativesObject, BufferAddress) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    VALIDATEARG(0, ARRAYBUFFER, "bufferAddress: argument 0 is not an ArrayBuffer");
    RT_ASSERT(arg0->IsArrayBuffer());
    auto abv8 = arg0.As<v8::ArrayBuffer>();
    if (0 == abv8->ByteLength()) {
        THROW_ERROR("Empty ArrayBuffer doesn't own a memory");
    }

    auto ab = ArrayBuffer::FromInstance(iv8, abv8);
    void* ptr = GLOBAL_mem_manager()->VirtualToPhysicalAddress(ab->data());
    uintptr_t addr = reinterpret_cast<uintptr_t>(ptr);
    uint32_t high = static_cast<uint32_t>(addr >> 32);
    uint32_t low = static_cast<uint32_t>(addr & 0xffffffffull);

    auto arr = v8::Array::New(iv8, 2);
    arr->Set(0, v8::Uint32::NewFromUnsigned(iv8, low));
    arr->Set(1, v8::Uint32::NewFromUnsigned(iv8, high));
    args.GetReturnValue().Set(arr);
}

NATIVE_FUNCTION(NativesObject, BufferSliceInplace) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    USEARG(1);
    USEARG(2);
    VALIDATEARG(0, ARRAYBUFFER, "argument 0 is not an ArrayBuffer");
    VALIDATEARG(1, NUMBER, "argument 1 is not a number");
    VALIDATEARG(2, NUMBER, "argument 2 is not a number");
    RT_ASSERT(arg0->IsArrayBuffer());
    auto abv8 = arg0.As<v8::ArrayBuffer>();
    if (0 == abv8->ByteLength()) {
        // Return the same buffer in case it's empty
        args.GetReturnValue().Set(arg0);
        return;
    }

    uint32_t offset = arg1->Uint32Value();
    uint32_t size = arg2->Uint32Value();

    if (offset + size >= abv8->ByteLength()) {
        THROW_ERROR("invalid offset and size");
    }

    auto ab = ArrayBuffer::FromInstance(iv8, abv8);
    auto abNew = ArrayBuffer::FromArrayBufferSlice(ab, offset, size);
    args.GetReturnValue().Set(abNew->GetInstance());
}

NATIVE_FUNCTION(NativesObject, CreatePipe) {
    PROLOGUE_NOTHIS;

    RuntimeStateScope<RuntimeState::PIPE_CREATE> pipe_scope(th->thread_manager());
    Pipe* pipe = GLOBAL_engines()->pipe_manager().CreatePipe();
    RT_ASSERT(pipe);

    RT_ASSERT(th->template_cache());
    args.GetReturnValue().Set((new PipeObject(pipe))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());
}

NATIVE_FUNCTION(NativesObject, ToBuffer) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    USEARG(1);
    v8::Local<v8::String> str = arg0->ToString();
    int len = str->Utf8Length();
    RT_ASSERT(len >= 0);

    bool null_terminate = arg1->BooleanValue();
    size_t buf_len = len;
    auto options = v8::String::WriteOptions::NO_NULL_TERMINATION;

    if (null_terminate) {
        options = v8::String::WriteOptions::NO_OPTIONS;
        ++buf_len;
    }

    char* data = nullptr;
    if (0 != buf_len) {
        data = new char[buf_len];
        str->WriteUtf8(data, buf_len, nullptr, options);
    }

    args.GetReturnValue().Set(ArrayBuffer::FromBuffer(iv8, data, buf_len)
        ->GetInstance());
}

NATIVE_FUNCTION(NativesObject, BufferToString) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    VALIDATEARG(0, ARRAYBUFFER, "bufferToString: argument 0 is not an ArrayBuffer");
    RT_ASSERT(arg0->IsArrayBuffer());
    auto abv8 = arg0.As<v8::ArrayBuffer>();

    if (0 == abv8->ByteLength()) {
        args.GetReturnValue().SetEmptyString();
        return;
    }

    auto ab = ArrayBuffer::FromInstance(iv8, abv8);
    args.GetReturnValue().Set(v8::String::NewFromUtf8(iv8,
        reinterpret_cast<const char*>(ab->data()), v8::String::kNormalString, ab->size()));
}

NATIVE_FUNCTION(NativesObject, HandlePoolCtorFunction) {
    PROLOGUE_NOTHIS;
    auto function_data = args.Data();
    RT_ASSERT(!function_data.IsEmpty());
    RT_ASSERT(function_data->IsExternal());
    HandlePool* pool = reinterpret_cast<HandlePool*>(function_data.As<v8::External>()->Value());
    RT_ASSERT(pool);
    if (!args.IsConstructCall()) {
        THROW_ERROR("operator 'new' required to call constructor");
    }

    TransportData data;
    {	TransportData::SerializeError err { data.MoveArgs(th, args) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    size_t handle_id = pool->AllocNextId();
    Pipe* wpipe = nullptr;
    Pipe* rpipe = nullptr;
    if (pool->pipes()) {
        wpipe = GLOBAL_engines()->pipe_manager().CreatePipe();
        rpipe = GLOBAL_engines()->pipe_manager().CreatePipe();
        auto obj = th->template_cache()->GetHandleInstance(pool->index(),
            handle_id, wpipe, rpipe);
        args.GetReturnValue().Set(obj);
    } else {
        auto obj = th->template_cache()->GetHandleInstance(pool->index(),
            handle_id, nullptr, nullptr);
        args.GetReturnValue().Set(obj);
    }

    if (pool->has_ctor()) {
        uint64_t pack = (static_cast<uint64_t>(pool->index()) << 32) | (0); // 0=ctor
        {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                ThreadMessage::Type::HANDLE_METHOD_CALL_NO_RETURN,
                th->handle(), std::move(data), wpipe, 0, pack, handle_id, rpipe));
            pool->thread_handle().getUnsafe()->PushMessage(std::move(msg));
        }
    }
}

NATIVE_FUNCTION(NativesObject, CreateHandlePool) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    USEARG(1);
    USEARG(2);

    SharedSTLVector<std::string> methods;
    SharedSTLVector<v8::Eternal<v8::Value>> impls;
    impls.reserve(2);

    if (arg2->IsObject()) {
        LOCAL_V8STRING(s_ctor, "ctor");
        LOCAL_V8STRING(s_dtor, "dtor");
        auto obj = arg2->ToObject();
        auto ctor = obj->Get(s_ctor);
        auto dtor = obj->Get(s_dtor);
        if (ctor->IsFunction()) {
            impls.push_back(v8::Eternal<v8::Value>(iv8, ctor));
        } else {
            THROW_TYPE_ERROR("ctor is not a function");
        }

        if (dtor->IsFunction()) {
            impls.push_back(v8::Eternal<v8::Value>(iv8, dtor));
        } else {
            THROW_TYPE_ERROR("dtor is not a function");
        }
    } else {
        impls.push_back(v8::Eternal<v8::Value>());
        impls.push_back(v8::Eternal<v8::Value>());
    }

    if (arg0->IsObject()) {
        auto obj = arg0->ToObject();

        auto namesArray = obj->GetOwnPropertyNames();
        methods.reserve(namesArray->Length());
        impls.reserve(namesArray->Length() + 2);

        for (uint32_t i = 0; i < namesArray->Length(); ++i) {
            auto name = namesArray->Get(i);
            auto value = obj->Get(name);

            if (!value->IsFunction()) {
                THROW_TYPE_ERROR("object value is not a function");
            }

            methods.push_back(V8Utils::ToString(name->ToString()));
            impls.push_back(v8::Eternal<v8::Value>(iv8, value));
        }
    }

    bool pipes = arg1->BooleanValue();

    RT_ASSERT(2 + methods.size() == impls.size());
    auto handle_pool = GLOBAL_engines()->handle_pools().CreateHandlePool(th, th->handle(),
        std::move(methods), std::move(impls), pipes);

    RT_ASSERT(handle_pool);
    args.GetReturnValue().Set((new HandlePoolObject(handle_pool))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());
}

NATIVE_FUNCTION(NativesObject, Resources) {
    PROLOGUE_NOTHIS;

    LOCAL_V8STRING(s_memory_range, "memoryRange");
    LOCAL_V8STRING(s_io_range, "ioRange");
    LOCAL_V8STRING(s_irq_range, "irqRange");
    LOCAL_V8STRING(s_isolates_manager, "isolatesManager");
    LOCAL_V8STRING(s_acpi, "acpi");
    LOCAL_V8STRING(s_allocator, "allocator");
    LOCAL_V8STRING(s_loader, "loader");
    LOCAL_V8STRING(s_natives, "natives");

    v8::Local<v8::Object> obj = v8::Object::New(iv8);

    obj->Set(s_memory_range, (new ResourceMemoryRangeObject(Range<size_t>(0, 0xffffffff)))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());

    obj->Set(s_io_range, (new ResourceIORangeObject(Range<uint16_t>(1, 0xffff)))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());

    obj->Set(s_irq_range, (new ResourceIRQRangeObject(Range<uint8_t>(1, 255)))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());

    obj->Set(s_isolates_manager, (new IsolatesManagerObject())
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());

    obj->Set(s_acpi, (new AcpiManagerObject(GLOBAL_engines()->acpi_manager()))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());

    obj->Set(s_allocator, (new AllocatorObject())
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());

    obj->Set(s_loader, v8::Function::New(iv8, KernelLoaderCallback));

    obj->Set(s_natives, (new NativesObject())
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());

    args.GetReturnValue().Set(obj);
}

NATIVE_FUNCTION(NativesObject, Args) {
    PROLOGUE_NOTHIS;
    v8::Local<v8::Value> threadargs = th->args();
    RT_ASSERT(!threadargs.IsEmpty());
    args.GetReturnValue().Set(threadargs);
}

NATIVE_FUNCTION(NativesObject, Exit) {
    PROLOGUE_NOTHIS;
    USEARG(0);

    v8::V8::TerminateExecution(iv8);
    th->SetTerminateFlag();
    th->SetExitValue(arg0);
}

NATIVE_FUNCTION(NativesObject, Eval) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, STRING, "eval: argument 0 is not a string");

    v8::TryCatch trycatch;
    v8::ScriptOrigin origin((!arg1.IsEmpty() && arg1->IsString())
                            ? arg1->ToString() : v8::String::Empty(iv8));
    v8::ScriptCompiler::Source source(arg0->ToString(), origin);
    v8::Local<v8::Script> script = v8::ScriptCompiler::Compile(iv8, &source,
        v8::ScriptCompiler::CompileOptions::kNoCompileOptions);

    if (!script.IsEmpty()) {
        v8::Local<v8::Value> result = script->Run();
        if (!result.IsEmpty()) {
            args.GetReturnValue().Set(result);
        }
    }


    v8::Local<v8::Value> ex = trycatch.Exception();
    if (!ex.IsEmpty() && !trycatch.HasTerminated()) {
        v8::String::Utf8Value exception_str(ex);
        v8::Local<v8::Message> message = trycatch.Message();
        if (message.IsEmpty()) {
            printf("Uncaught exception: %s\n", *exception_str);
        } else {
            v8::String::Utf8Value script_name(message->GetScriptResourceName());
            int linenum = message->GetLineNumber();
            printf("Uncaught exception: %s:%i: %s\n", *script_name, linenum, *exception_str);
        }

        v8::String::Utf8Value stack(trycatch.StackTrace());
        if (stack.length() > 0) {
            printf("%s\n", *stack);
        }

        RT_ASSERT(!"syntax error");
    }
}

NATIVE_FUNCTION(NativesObject, Version) {
    PROLOGUE_NOTHIS;

    auto arr = v8::Array::New(iv8, 3);
    arr->Set(0, v8::Uint32::NewFromUnsigned(iv8, Version::getMajor()));
    arr->Set(1, v8::Uint32::NewFromUnsigned(iv8, Version::getMinor()));
    arr->Set(2, v8::Uint32::NewFromUnsigned(iv8, Version::getRev()));

    auto obj = v8::Object::New(iv8);
    LOCAL_V8STRING(s_runtime, "runtime");
    LOCAL_V8STRING(s_v8, "v8");
    LOCAL_V8STRING(s_v8ver, v8::V8::GetVersion());
    obj->Set(s_runtime, arr);
    obj->Set(s_v8, s_v8ver);

    args.GetReturnValue().Set(obj);
}

NATIVE_FUNCTION(NativesObject, InstallInternals) {
    PROLOGUE_NOTHIS;
    USEARG(0);

    RT_ASSERT(arg0->IsObject());
    v8::Local<v8::Object> obj { arg0->ToObject() };
    v8::Local<v8::String> call_wrapper_name { v8::String::NewFromUtf8(iv8, "callWrapper") };
    RT_ASSERT(obj->HasOwnProperty(call_wrapper_name));
    {	v8::Local<v8::Value> fnv { obj->Get(call_wrapper_name) };
        RT_ASSERT(fnv->IsFunction());
        v8::Local<v8::Function> fn { v8::Local<v8::Function>::Cast(fnv) };
        th->SetCallWrapper(fn);
    }
}

NATIVE_FUNCTION(NativesObject, IsolatesInfo) {
    PROLOGUE_NOTHIS;
    RT_ASSERT(th->thread_manager());

    LOCAL_V8STRING(s_name, "name");
    LOCAL_V8STRING(s_eventsCount, "eventsCount");
    LOCAL_V8STRING(s_runtime, "runtime");

    auto list = th->thread_manager()->List();
    auto arr = v8::Array::New(iv8, list.size());

    size_t index = 0;
    for (auto& info : list) {
        auto obj = v8::Object::New(iv8);
        // TODO: ensure those uint64 fit into doubles
        obj->Set(s_name, V8Utils::FromString(iv8, info.filename));
        obj->Set(s_eventsCount, v8::Number::New(iv8, static_cast<double>(info.ev_count)));
        obj->Set(s_runtime, v8::Number::New(iv8, static_cast<double>(info.runtime)));
        arr->Set(index++, obj);
    }

    args.GetReturnValue().Set(arr);
}

NATIVE_FUNCTION(NativesObject, Reboot) {
    PROLOGUE_NOTHIS;
    GLOBAL_platform()->Reboot();
    Cpu::HangSystem();
}

void PrintMemory(void* buf, size_t offset, size_t size) {
    uint8_t* p = reinterpret_cast<uint8_t*>(buf);
    size_t counter = 0;
    for (size_t i = offset; i < size; ++i) {
        ++counter;
        printf("0x%02x ", p[i]);
        if (0 == counter % 16) {
            printf("\n");
        } else if (0 == counter % 8) {
            printf("| ");
        }
    }
    printf("\n");
}

NATIVE_FUNCTION(NativesObject, Debug) {
    PROLOGUE_NOTHIS;
    USEARG(0);

    printf(" --- DEBUG --- \n");
    if (arg0->IsArrayBufferView()) {
        v8::Local<v8::ArrayBufferView> view = arg0.As<v8::ArrayBufferView>();
        auto ab = ArrayBuffer::FromInstance(iv8, view->Buffer());
        auto offset = view->ByteOffset();
        auto len = view->ByteLength();
        printf("[ ArrayBufferView  ptr=%p offset=%lu len=%lu bufsize=%lu ]\n", ab->data(), offset, len, ab->size());
        if (0 != ab->size()) {
            PrintMemory(ab->data(), offset, offset + len);
        }
    } else if (arg0->IsArrayBuffer()) {
        v8::Local<v8::ArrayBuffer> buf = arg0.As<v8::ArrayBuffer>();
        auto ab = ArrayBuffer::FromInstance(iv8, buf);
        printf("[ ArrayBuffer  ptr=%p bufsize=%lu ]\n", ab->data(), ab->size());
        if (0 != ab->size()) {
            PrintMemory(ab->data(), 0, std::min(ab->size(), (size_t)600));
        }
        return;
    } else if (arg0->IsObject()) {
        NativeObjectWrapper* ptr { th->template_cache()->GetWrapped(arg0) };
        if (nullptr != ptr) {
            switch (ptr->type_id()) {
                case NativeTypeId::TYPEID_HANDLE: {
                    HandleObject* baseptr { static_cast<HandleObject*>(ptr) };
                    printf("[ HandleObject pool_id=%lu handle_id=%lu wpipe=%p rpipe=%p ]\n",
                        baseptr->pool_id(), baseptr->handle_id(), baseptr->wpipe(), baseptr->rpipe());
                    return;
                }
                default:
                    break;
            }
        }
    }

//    printf(" --- STOP --- \n");
//    Cpu::HangSystem();
}

NATIVE_FUNCTION(NativesObject, PerformanceNow) {
    PROLOGUE_NOTHIS;
    double value = GLOBAL_platform()->BootTimeMicroseconds() / 1000.0;
    args.GetReturnValue().Set(v8::Number::New(iv8, value));
}

NATIVE_FUNCTION(NativesObject, StopVideoLog) {
    PROLOGUE_NOTHIS;
    GLOBAL_boot_services()->logger()->DisableVideo();
}

NATIVE_FUNCTION(NativesObject, HandleIndex) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    auto handle_object = HandleObject::FromInstance(arg0);
    if (nullptr == handle_object) {
        THROW_ERROR("argument 0 is not a handle object");
    }

    RT_ASSERT(handle_object);
    args.GetReturnValue().Set(v8::Uint32::NewFromUnsigned(iv8, handle_object->handle_id()));
}

NATIVE_FUNCTION(NativesObject, HandleGetPipe) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    USEARG(1);
    auto handle_object = HandleObject::FromInstance(arg0);
    if (nullptr == handle_object) {
        THROW_ERROR("argument 0 is not a handle object");
    }

    uint32_t index = arg1->Uint32Value();
    Pipe* pipe = nullptr;
    if (0 == index) {
        pipe = handle_object->wpipe();
    } else {
        pipe = handle_object->rpipe();
    }

    if (!pipe) {
        THROW_ERROR("could not get handle pipe");
    }

    RT_ASSERT(pipe);
    args.GetReturnValue().Set((new PipeObject(pipe))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());
}

NATIVE_FUNCTION(IoPortX64Object, Write8) {
    PROLOGUE;
    USEARG(0);
    uint8_t value = arg0->Uint32Value() & 0xFF;
    IoPortsX64::OutB(that->port_number_, value);
    args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(IoPortX64Object, Write16) {
    PROLOGUE;
    USEARG(0);
    uint16_t value = arg0->Uint32Value() & 0xFFFF;
    IoPortsX64::OutW(that->port_number_, value);
    args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(IoPortX64Object, Write32) {
    PROLOGUE;
    USEARG(0);
    uint32_t value = arg0->Uint32Value();
    IoPortsX64::OutDW(that->port_number_, value);
    args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(IoPortX64Object, Read8) {
    PROLOGUE;
    uint8_t value = IoPortsX64::InB(that->port_number_);
    args.GetReturnValue().Set(static_cast<uint32_t>(value));
}

NATIVE_FUNCTION(IoPortX64Object, Read16) {
    PROLOGUE;
    uint16_t value = IoPortsX64::InW(that->port_number_);
    args.GetReturnValue().Set(static_cast<uint32_t>(value));
}

NATIVE_FUNCTION(IoPortX64Object, Read32) {
    PROLOGUE;
    uint32_t value = IoPortsX64::InDW(that->port_number_);
    args.GetReturnValue().Set(static_cast<uint32_t>(value));
}

NATIVE_FUNCTION(AcpiHandleObject, IsRootBridge) {
    PROLOGUE;
    ACPI_DEVICE_INFO* devinfo = that->GetInfo();
    RT_ASSERT(devinfo);
    args.GetReturnValue().Set(v8::Boolean::New(iv8, devinfo->Flags & ACPI_PCI_ROOT_BRIDGE));
}

NATIVE_FUNCTION(AcpiHandleObject, IsDevice) {
    PROLOGUE;
    ACPI_DEVICE_INFO* devinfo = that->GetInfo();
    RT_ASSERT(devinfo);

    if (0 == (ACPI_VALID_ADR & devinfo->Valid)) {
        args.GetReturnValue().Set(v8::False(iv8));
        return;
    }

    if (ACPI_TYPE_DEVICE != devinfo->Type) {
        args.GetReturnValue().Set(v8::False(iv8));
        return;
    }

    args.GetReturnValue().Set(v8::True(iv8));
}

NATIVE_FUNCTION(AcpiHandleObject, Address) {
    PROLOGUE;
    ACPI_DEVICE_INFO* devinfo = that->GetInfo();
    RT_ASSERT(devinfo);
    args.GetReturnValue().Set(v8::Uint32::New(iv8, devinfo->Address & 0xffffffff));
}

NATIVE_FUNCTION(AcpiHandleObject, Parent) {
    PROLOGUE;
    ACPI_HANDLE parent_handle;
    ACPI_STATUS s = AcpiGetParent(that->handle_, &parent_handle);

    if (ACPI_FAILURE(s)) {
        args.GetReturnValue().Set(v8::Null(iv8));
    }

    args.GetReturnValue().Set((new AcpiHandleObject(parent_handle))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());
}

NATIVE_FUNCTION(AcpiHandleObject, HardwareId) {
    PROLOGUE;
    ACPI_DEVICE_INFO* devinfo = that->GetInfo();
    RT_ASSERT(devinfo);
    char* hwid { devinfo->HardwareId.String };
    uint32_t len = devinfo->HardwareId.Length;

    if (nullptr == hwid || 0 == len) {
        args.GetReturnValue().Set(v8::String::Empty(iv8));
        return;
    }

    RT_ASSERT(len > 0);
    RT_ASSERT('\0' == hwid[len - 1]);
    args.GetReturnValue().Set(v8::String::NewFromUtf8(iv8, hwid,
        v8::String::kNormalString, len - 1));
}

class WalkResourcesIrqContext {
public:
    WalkResourcesIrqContext(AcpiPciIrqRoutingTable* routes,
                            uint8_t device, uint8_t pin, uint8_t source_index)
        :	_routes(routes),
            _device(device),
            _pin(pin),
            _source_index(source_index) {
        RT_ASSERT(_routes);
    }
    AcpiPciIrqRoutingTable* routes() const { return _routes; }
    uint8_t device() const { return _device; }
    uint8_t pin() const { return _pin; }
    uint8_t source_index() const { return _source_index; }
private:
    AcpiPciIrqRoutingTable* _routes;
    uint8_t _device;
    uint8_t _pin;
    uint8_t _source_index;
};

ACPI_STATUS WalkResourcesCallback(ACPI_RESOURCE *res, void *context) {
    RT_ASSERT(res);
    RT_ASSERT(context);
    WalkResourcesIrqContext* ct = reinterpret_cast<WalkResourcesIrqContext*>(context);
    RT_ASSERT(ct);
    RT_ASSERT(ct->routes());

    switch (res->Type) {
    case ACPI_RESOURCE_TYPE_IRQ: {
        ACPI_RESOURCE_IRQ* irq = &res->Data.Irq;
        if (nullptr == irq || 0 == irq->InterruptCount) {
            break;
        }
        RT_ASSERT(ct->source_index() < irq->InterruptCount);
        ct->routes()->AddRoute(AcpiPciIrqRoute(ct->device(), ct->pin(),
            irq->Interrupts[ct->source_index()]));
    }
        break;
    case ACPI_RESOURCE_TYPE_EXTENDED_IRQ: {
        ACPI_RESOURCE_EXTENDED_IRQ* irq = &res->Data.ExtendedIrq;
        if (nullptr == irq || 0 == irq->InterruptCount) {
            break;
        }
        RT_ASSERT(ct->source_index() < irq->InterruptCount);
        ct->routes()->AddRoute(AcpiPciIrqRoute(ct->device(), ct->pin(),
            irq->Interrupts[ct->source_index()]));
    }
        break;
    default:
        break;
    }

    return AE_OK;
}

NATIVE_FUNCTION(AcpiHandleObject, GetIrqRoutingTable) {
    PROLOGUE;
    const size_t kBufSize = 8192;
    std::array<char, kBufSize> databuf;
    RT_ASSERT(databuf.data());
    databuf.fill(0);

    RT_ASSERT(that->handle_);
    ACPI_BUFFER buf;
    buf.Length = kBufSize;
    buf.Pointer = databuf.data();
    ACPI_STATUS s = AcpiGetIrqRoutingTable(that->handle_, &buf);

    if (ACPI_FAILURE(s)) {
        printf("FAILLLL %s.\n", AcpiFormatException(s));
        args.GetReturnValue().Set(v8::Array::New(iv8, 0));
    }

    RT_ASSERT(buf.Pointer);
    RT_ASSERT(buf.Length > 0);

    AcpiPciIrqRoutingTable routes;

    ACPI_PCI_ROUTING_TABLE* table = reinterpret_cast<ACPI_PCI_ROUTING_TABLE*>(buf.Pointer);
    RT_ASSERT(table);
    for (; table->Length; table =
            reinterpret_cast<ACPI_PCI_ROUTING_TABLE*>(
            reinterpret_cast<uint8_t*>(table) + table->Length)) {

        RT_ASSERT(table);
        uint8_t device_id = table->Address >> 16;
        uint8_t func_id = table->Address & 0xFFFF;
        uint8_t pin = table->Pin;
        uint8_t source_index = table->SourceIndex;

        char* src = reinterpret_cast<char*>(table->Source);
        if ('\0' == src[0]) {
            routes.AddRoute(AcpiPciIrqRoute(device_id, pin, source_index));
            continue;
        }

        ACPI_HANDLE source;
        s = AcpiGetHandle(that->handle_, table->Source, &source);
        if (ACPI_FAILURE(s)) {
            printf("Failed AcpiGetHandle %s\n", AcpiFormatException(s));
            continue;
        }

        WalkResourcesIrqContext context(&routes, device_id, pin, source_index);
        char crs[] = "_CRS";
        s = AcpiWalkResources(source, crs, WalkResourcesCallback, &context);
        if (ACPI_FAILURE(s)) {
            printf("Failed IRQ resource\n");
            continue;
        }
    }

    v8::Local<v8::String> str_device_id = v8::String::NewFromUtf8(iv8, "deviceId");
    v8::Local<v8::String> str_irq = v8::String::NewFromUtf8(iv8, "irq");
    v8::Local<v8::String> str_pin = v8::String::NewFromUtf8(iv8, "pin");

    v8::Local<v8::Array> arr = v8::Array::New(iv8, routes.size());
    for (size_t i = 0; i < routes.size(); ++i) {
        v8::Local<v8::Object> row = v8::Object::New(iv8);
        row->Set(str_device_id, v8::Uint32::New(iv8, routes.Get(i).device()));
        row->Set(str_irq, v8::Uint32::New(iv8, routes.Get(i).irq()));
        row->Set(str_pin, v8::Uint32::New(iv8, routes.Get(i).pin()));
        arr->Set(i, row);
    }

    args.GetReturnValue().Set(arr);
}

ACPI_STATUS WalkResourcesBusLookupCallback(ACPI_RESOURCE *res, void* context) {
    ACPI_RESOURCE_ADDRESS64 addr64;
    int32_t* bus = reinterpret_cast<int32_t*>(context);

    if ((res->Type != ACPI_RESOURCE_TYPE_ADDRESS16) &&
        (res->Type != ACPI_RESOURCE_TYPE_ADDRESS32) &&
        (res->Type != ACPI_RESOURCE_TYPE_ADDRESS64)) {
        return AE_OK;
    }

    if (ACPI_FAILURE(AcpiResourceToAddress64(res, &addr64))) {
        return AE_OK;
    }

    if (addr64.ResourceType != ACPI_BUS_NUMBER_RANGE) {
        return AE_OK;
    }

    if (*bus != -1) {
        return AE_ALREADY_EXISTS;
    }

    if (addr64.Minimum > 0xFFFF) {
        return AE_BAD_DATA;
    }

    *bus = (int32_t)addr64.Minimum;
    return AE_OK;
}

ACPI_STATUS EvalObjectTyped(ACPI_HANDLE handle, const char* pathname,
        ACPI_OBJECT_LIST* external_params,
        ACPI_BUFFER* return_buffer, ACPI_OBJECT_TYPE return_type) {

    RT_ASSERT(4 == strnlen(pathname, 5));
    char path[5];
    strncpy(path, pathname, 4);
    path[4] = '\0';
    return AcpiEvaluateObjectTyped(handle, path, external_params, return_buffer, return_type);
}

ACPI_STATUS EvalInteger(ACPI_HANDLE handle, const char* name, ACPI_INTEGER* ret) {
    RT_ASSERT(ret != nullptr);
    ACPI_STATUS as;
    char intbuf[sizeof(ACPI_OBJECT)];

    ACPI_BUFFER intbufobj;
    intbufobj.Length = sizeof(intbuf);
    intbufobj.Pointer = intbuf;

    as = EvalObjectTyped(handle, name, NULL, &intbufobj, ACPI_TYPE_INTEGER);
    if (ACPI_SUCCESS(as)) {
        ACPI_OBJECT* obj = reinterpret_cast<ACPI_OBJECT*>(intbufobj.Pointer);
        *ret = obj->Integer.Value;
    }

    return as;
}

ACPI_STATUS WalkResources(ACPI_HANDLE device_handle, const char* pathname,
        ACPI_WALK_RESOURCE_CALLBACK user_function, void* context) {
    RT_ASSERT(4 == strnlen(pathname, 5));
    char path[5];
    strncpy(path, pathname, 4);
    path[4] = '\0';
    return AcpiWalkResources(device_handle, path, user_function, context);
}

NATIVE_FUNCTION(AcpiHandleObject, GetRootBridgeBusNumber) {
    PROLOGUE;

    // Method1: Use _BBN on root bridge
    ACPI_INTEGER busnum;
    ACPI_STATUS as = EvalInteger(that->handle_, "_BBN", &busnum);
    if (ACPI_SUCCESS(as)) {
        args.GetReturnValue().Set(v8::Uint32::New(iv8, busnum & 0xFF));
    }

    // Method2: Search for bus number in resources
    int32_t invalid_bus = -1;
    int32_t bus = invalid_bus;
    ACPI_STATUS s = WalkResources(that->handle_, "_CRS", WalkResourcesBusLookupCallback, &bus);
    if (ACPI_FAILURE(s) || invalid_bus == bus) {
        args.GetReturnValue().SetNull();
        return;
    }

    args.GetReturnValue().Set(v8::Uint32::New(iv8, s));
}

NATIVE_FUNCTION(AcpiManagerObject, EnterSleepState) {
    PROLOGUE_NOTHIS;
    USEARG(0);
    GLOBAL_platform()->EnterSleepState(arg0->Uint32Value());
}

NATIVE_FUNCTION(AcpiManagerObject, SystemReset) {
    PROLOGUE;
    AcpiReset();
}

NATIVE_FUNCTION(AcpiManagerObject, GetPciDevices) {
    PROLOGUE;

    AcpiObjectsList list = that->mgr_->GetPciDevices();
    v8::Local<v8::Array> arr = v8::Array::New(iv8, list.size());

    for (size_t i = 0; i < list.size(); ++i) {
        arr->Set(i, (new AcpiHandleObject(list.Get(i)))
            ->BindToTemplateCache(th->template_cache())
            ->GetInstance());
    }

    args.GetReturnValue().Set(arr);
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, Begin) {
    PROLOGUE;
    auto begin = that->memory_range_.begin();
    RT_ASSERT(Utils::IsSafeDouble(begin));
    args.GetReturnValue().Set(v8::Number::New(iv8, begin));
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, End) {
    PROLOGUE;
    auto end = that->memory_range_.end();
    RT_ASSERT(Utils::IsSafeDouble(end));
    args.GetReturnValue().Set(v8::Number::New(iv8, end));
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, Subrange) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, NUMBER, "subrange: argument 0 is not a number");
    VALIDATEARG(1, NUMBER, "subrange: argument 1 is not a number");

    auto begin = static_cast<size_t>(arg0->NumberValue());
    auto end = static_cast<size_t>(arg1->NumberValue());

    if (begin > end) {
        THROW_RANGE_ERROR("subrange: invalid range (begin > end)");
    }

    Range<size_t> subrange(begin, end);
    if (!subrange.IsSubrangeOf(that->memory_range_)) {
        THROW_RANGE_ERROR("subrange: invalid range (out of bounds)");
    }

    args.GetReturnValue().Set((new ResourceMemoryRangeObject(subrange))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());
}

NATIVE_FUNCTION(ResourceMemoryRangeObject, Block) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, NUMBER, "block: argument 0 is not a number");
    VALIDATEARG(1, NUMBER, "block: argument 1 is not a number");

    auto base = static_cast<uint64_t>(arg0->NumberValue());
    auto size = static_cast<uint32_t>(arg1->Uint32Value());

    Range<size_t> subrange(base, base + size);
    if (!subrange.IsSubrangeOf(that->memory_range_)) {
        THROW_RANGE_ERROR("block: out of bounds");
    }

    args.GetReturnValue().Set((new ResourceMemoryBlockObject(
        MemoryBlock<uint32_t>(reinterpret_cast<void*>(base), size)))
            ->BindToTemplateCache(th->template_cache())
            ->GetInstance());
}

NATIVE_FUNCTION(ResourceIORangeObject, Begin) {
    PROLOGUE;
    auto begin = that->io_range_.begin();
    args.GetReturnValue().Set(v8::Uint32::New(iv8, begin));
}

NATIVE_FUNCTION(ResourceIORangeObject, End) {
    PROLOGUE;
    auto end = that->io_range_.end();
    args.GetReturnValue().Set(v8::Uint32::New(iv8, end));
}

NATIVE_FUNCTION(ResourceIORangeObject, Subrange) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    VALIDATEARG(0, NUMBER, "subrange: argument 0 is not a number");
    VALIDATEARG(1, NUMBER, "subrange: argument 1 is not a number");

    auto begin = static_cast<uint32_t>(arg0->Uint32Value());
    auto end = static_cast<uint32_t>(arg1->Uint32Value());

    if (begin > end) {
        THROW_RANGE_ERROR("subrange: invalid range (begin > end)");
    }

    Range<uint16_t> subrange(begin, end);
    if (!subrange.IsSubrangeOf(that->io_range_)) {
        THROW_RANGE_ERROR("subrange: invalid range (out of bounds)");
    }

    args.GetReturnValue().Set((new ResourceIORangeObject(subrange))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());
}

NATIVE_FUNCTION(ResourceIORangeObject, Port) {
    PROLOGUE;
    USEARG(0);
    VALIDATEARG(0, NUMBER, "port: argument 0 is not a number");

    auto number = arg0->Uint32Value();
    if (!that->io_range_.Contains(number)) {
        THROW_RANGE_ERROR("port: invalid port number (required <= 0xffff)");
    }

    args.GetReturnValue().Set((new IoPortX64Object(number))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());
}

NATIVE_FUNCTION(ResourceIORangeObject, OffsetPort) {
    PROLOGUE;
    USEARG(0);
    VALIDATEARG(0, NUMBER, "offsetPort: argument 0 is not a number");

    auto number = that->io_range_.begin() + arg0->Uint32Value();
    if (!that->io_range_.Contains(number)) {
        THROW_RANGE_ERROR("offsetPort: port offset is out of range");
    }

//    printf("[OFFSET PORT] base = %d, offset = %d, result = %d\n",
//        that->io_range_.begin(), arg0->Uint32Value(), number);
    args.GetReturnValue().Set((new IoPortX64Object(number))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());
}

NATIVE_FUNCTION(ResourceIRQRangeObject, Irq) {
    PROLOGUE;
    USEARG(0);
    VALIDATEARG(0, NUMBER, "irq: argument 0 is not a number");

    uint32_t number = arg0->Uint32Value();
    if (!that->irq_range_.Contains(number)) {
        THROW_RANGE_ERROR("irq: irq number is out of range");
    }

    args.GetReturnValue().Set((new ResourceIRQObject(number))
        ->BindToTemplateCache(th->template_cache())
        ->GetInstance());
}

NATIVE_FUNCTION(ResourceIRQObject, On) {
    PROLOGUE;
    USEARG(0);
    VALIDATEARG(0, FUNCTION, "on: argument 0 is not a function");

    ResourceHandle<EngineThread> thread { th->handle() };
    RT_ASSERT(!thread.empty());

    auto irq_number = that->irq_number_;

    uint32_t index { th->PutObject(v8::UniquePersistent<v8::Value>(iv8, arg0)) };
    GLOBAL_platform()->irq_dispatcher().Bind(irq_number, thread, index);

    printf("[IRQ MANAGER] Bind %d (recv %d)\n", irq_number, index);
    args.GetReturnValue().SetUndefined();
}

NATIVE_FUNCTION(ResourceMemoryBlockObject, Buffer) {
    PROLOGUE;
    void* ptr = that->memory_block_.base();
    auto length = that->memory_block_.size();
    RT_ASSERT(ptr);
    RT_ASSERT(length > 0);
    auto abv8 = ArrayBuffer::FromBuffer(iv8, ptr, length)->GetInstance();
    args.GetReturnValue().Set(abv8);
}

NATIVE_FUNCTION(ResourceMemoryBlockObject, Length) {
    PROLOGUE;
    auto length = that->memory_block_.size();
    args.GetReturnValue().Set(v8::Uint32::New(iv8, length));
}

NATIVE_FUNCTION(IsolatesManagerObject, Create) {
    PROLOGUE;
    USEARG(0);
    USEARG(1);
    RT_ASSERT(arg0->IsArray());
    RT_ASSERT(2 == arg0.As<v8::Array>()->Length());
    RT_ASSERT(arg1->IsObject());

    RT_ASSERT(GLOBAL_engines()->execution_engines_count() > 0);
    Engine* first_engine = GLOBAL_engines()->execution_engine(0);
    RT_ASSERT(first_engine);

    TransportData td_code;
    {	TransportData::SerializeError err { td_code.MoveValue(th, arg0) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    TransportData td_args;
    {	TransportData::SerializeError err { td_args.MoveValue(th, arg1) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    v8::Local<v8::Promise::Resolver> promise_resolver;
    {   RuntimeStateScope<RuntimeState::PROMISE_NATIVE_API> promise_scope(th->thread_manager());
        promise_resolver = v8::Promise::Resolver::New(iv8);
    }

    auto promise_index = th->AddPromise(
        v8::UniquePersistent<v8::Promise::Resolver>(iv8, promise_resolver));

    ResourceHandle<EngineThread> st = first_engine->threads().Create(ThreadType::DEFAULT);

    {	LockingPtr<EngineThread> thread { st.get() };

        {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                ThreadMessage::Type::SET_ARGUMENTS,
                th->handle(),
                std::move(td_args),
                nullptr, promise_index));
            thread->PushMessage(std::move(msg));
        }

        {	std::unique_ptr<ThreadMessage> msg(new ThreadMessage(
                ThreadMessage::Type::EVALUATE,
                th->handle(),
                std::move(td_code)));
            thread->PushMessage(std::move(msg));
        }
    }

    args.GetReturnValue().Set(promise_resolver);
}

NATIVE_FUNCTION(IsolatesManagerObject, List) {
    PROLOGUE;
    Engine* first_engine = GLOBAL_engines()->execution_engine(0);
    auto list = first_engine->thread_manager()->List();

    v8::Local<v8::Array> result { v8::Array::New(iv8, list.size()) };
    for (size_t i = 0; i < list.size(); ++i) {
        auto& item = list[i];
        v8::Local<v8::Object> dat { v8::Object::New(iv8) };

        // TODO: add data

        result->Set(i, dat);
    }

    args.GetReturnValue().Set(result);
}

NATIVE_FUNCTION(AllocatorObject, AllocDMA) {
    PROLOGUE;

    LOCAL_V8STRING(s_address, "address");
    LOCAL_V8STRING(s_size, "size");
    LOCAL_V8STRING(s_buffer, "buffer");

    void* ptr { GLOBAL_mem_manager()->AllocPage32() };
    RT_ASSERT(ptr);

    size_t ptrvalue { reinterpret_cast<size_t>(ptr) };
    RT_ASSERT(ptrvalue == (ptrvalue & 0xffffffff));

    size_t size { GLOBAL_mem_manager()->page_size() };
    RT_ASSERT(size > 0);

    printf("DMA allocated = %p, size %d\n", ptr, size);
    // Clean DMA buffer
    memset(ptr, 0, size);

    v8::Local<v8::Object> ret { v8::Object::New(iv8) };
    ret->Set(s_address, v8::Uint32::New(iv8, static_cast<uint32_t>(ptrvalue)));
    ret->Set(s_size, v8::Uint32::New(iv8, static_cast<uint32_t>(size)));
    ret->Set(s_buffer, ArrayBuffer::FromBuffer(iv8, ptr, size)->GetInstance());

    args.GetReturnValue().Set(ret);
}

NATIVE_FUNCTION(HandlePoolObject, CreateHandle) {
    PROLOGUE;
    RT_ASSERT(that->pool_);
    if (that->pool_->pipes()) {
        USEARG(0);
        USEARG(1);
        PipeObject* wpipe_object = PipeObject::FromHandle(th, arg0);
        PipeObject* rpipe_object = PipeObject::FromHandle(th, arg1);
        auto obj = th->template_cache()->GetHandleInstance(that->pool_->index(),
            that->pool_->AllocNextId(), wpipe_object->pipe(), rpipe_object->pipe());
        args.GetReturnValue().Set(obj);
    } else {
        auto obj = th->template_cache()->GetHandleInstance(that->pool_->index(),
            that->pool_->AllocNextId(), nullptr, nullptr);
        args.GetReturnValue().Set(obj);
    }
}


NATIVE_FUNCTION(HandlePoolObject, Ctor) {
    PROLOGUE;
    RT_ASSERT(that->pool_);
    args.GetReturnValue().Set(th->template_cache()->GetHandleCtor(that->pool_));
}

NATIVE_FUNCTION(HandlePoolObject, Has) {
    PROLOGUE;
    USEARG(0);
    auto handle_object = HandleObject::FromInstance(arg0);
    if (nullptr == handle_object) {
        THROW_ERROR("argument 0 is not a handle object");
    }

    RT_ASSERT(handle_object);
    RT_ASSERT(that->pool_);
    if (handle_object->pool_id() != that->pool_->index()) {
        args.GetReturnValue().Set(v8::False(iv8));
        return;
    }

    RT_ASSERT(handle_object->handle_id() < that->pool_->max_handle_id());
    args.GetReturnValue().Set(v8::True(iv8));
}

void PipeObject::PushImpl(Pipe* pipe, const v8::FunctionCallbackInfo<v8::Value>& args) {
    auto th = V8Utils::GetThread(args);
    auto iv8 = args.GetIsolate();
    RT_ASSERT(th);
    RT_ASSERT(iv8);
    RT_ASSERT(pipe);
    USEARG(0);

    TransportData data;
    {	TransportData::SerializeError err { data.MoveValue(th, arg0) };
        if (TransportData::ThrowError(iv8, err)) return;
    }

    RuntimeStateScope<RuntimeState::PIPE_PUSH> pipe_scope(th->thread_manager());
    bool result = pipe->Push(std::move(data));
    args.GetReturnValue().Set(v8::Boolean::New(iv8, result));
}

void PipeObject::PullImpl(Pipe* pipe, const v8::FunctionCallbackInfo<v8::Value>& args) {
    auto th = V8Utils::GetThread(args);
    auto iv8 = args.GetIsolate();
    RT_ASSERT(th);
    RT_ASSERT(iv8);
    RT_ASSERT(pipe);
    USEARG(0);
    ResourceHandle<EngineThread> thread { th->handle() };
    RT_ASSERT(!thread.empty());

    uint32_t index = 0;
    uint32_t count = 0;
    if (arg0->IsNumber()) {
        USEARG(1);
        VALIDATEARG(1, FUNCTION, "argument 1 is not a function");
        count = arg0->Uint32Value();
        index = th->PutObject(v8::UniquePersistent<v8::Value>(iv8, arg1));
    } else {
        VALIDATEARG(0, FUNCTION, "argument 0 is not a function");
        count = 1;
        index = th->PutObject(v8::UniquePersistent<v8::Value>(iv8, arg0));
    }

    RT_ASSERT(count > 0);
    RuntimeStateScope<RuntimeState::PIPE_PULL> pipe_scope(th->thread_manager());
    pipe->Pull(thread, index, count);
}

NATIVE_FUNCTION(HandleObject, PipePush) {
    PROLOGUE_NOTHIS;
    if (args.IsConstructCall()) {
        THROW_ERROR("function is not a constructor");
    }

    auto thisvalue = args.This();
    if (thisvalue.IsEmpty() || !thisvalue->IsObject()) {
        THROW_ERROR("illegal invocation");
    }

    HandleObject* handle_object = HandleObject::FromInstance(thisvalue);
    if (nullptr == handle_object) {
        THROW_ERROR("illegal invocation");
    }

    PipeObject::PushImpl(handle_object->wpipe_, args);
}

NATIVE_FUNCTION(HandleObject, PipePull) {
    PROLOGUE_NOTHIS;
    if (args.IsConstructCall()) {
        THROW_ERROR("function is not a constructor");
    }

    auto thisvalue = args.This();
    if (thisvalue.IsEmpty() || !thisvalue->IsObject()) {
        THROW_ERROR("illegal invocation");
    }

    HandleObject* handle_object = HandleObject::FromInstance(thisvalue);
    if (nullptr == handle_object) {
        THROW_ERROR("illegal invocation");
    }

    PipeObject::PullImpl(handle_object->rpipe_, args);
}

NATIVE_FUNCTION(HandleObject, PipeClose) {
    PROLOGUE_NOTHIS;
    if (args.IsConstructCall()) {
        THROW_ERROR("function is not a constructor");
    }

    auto thisvalue = args.This();
    if (thisvalue.IsEmpty() || !thisvalue->IsObject()) {
        THROW_ERROR("illegal invocation");
    }

    HandleObject* handle_object = HandleObject::FromInstance(thisvalue);
    if (nullptr == handle_object) {
        THROW_ERROR("illegal invocation");
    }

    if (handle_object->wpipe_) {
        handle_object->wpipe_->Close();
    }

    if (handle_object->rpipe_) {
        handle_object->rpipe_->Close();
    }
}


NATIVE_FUNCTION(PipeObject, Push) {
    PROLOGUE;
    PushImpl(that->pipe_, args);
}

NATIVE_FUNCTION(PipeObject, Pull) {
    PROLOGUE;
    PullImpl(that->pipe_, args);
}

NATIVE_FUNCTION(PipeObject, Wait) {
    PROLOGUE;
    USEARG(0);
    VALIDATEARG(0, FUNCTION, "argument 0 is not a function");

    RT_ASSERT(that->pipe_);
    ResourceHandle<EngineThread> thread { th->handle() };
    RT_ASSERT(!thread.empty());
    uint32_t index { th->PutObject(v8::UniquePersistent<v8::Value>(iv8, arg0)) };
    that->pipe_->Wait(thread, index);
}

NATIVE_FUNCTION(PipeObject, Close) {
    PROLOGUE;
    RT_ASSERT(that->pipe_);
    that->pipe_->Close();
}

} // namespace rt

