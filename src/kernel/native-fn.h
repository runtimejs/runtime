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

#pragma once
#include <kernel/kernel.h>
#include <kernel/object-wrapper.h>

namespace rt {

/**
 * Represents external function, exported from other context
 * or isolate. Containts all data required to make RPC
 * function call. Inherits native object wrapper, so its
 * possible to wrap this into v8 object instance
 */
class ExternalFunction : public NativeObjectWrapper {
public:
    ExternalFunction(uint32_t index, size_t export_id, Thread* thread,
                     ResourceHandle<EngineThread> recv)
        :	NativeObjectWrapper(NativeTypeId::TYPEID_FUNCTION),
            index_(index), export_id_(export_id),
            thread_(thread), recv_(recv) {
        RT_ASSERT(thread_);
    }

    /**
     * ID allocated by function impementor
     */
    uint32_t index() const { return index_; }

    /**
     * Isolate which implements function
     */
    Thread* thread() const { return thread_; }

    /**
     * Unique exported function ID
     */
    size_t export_id() const { return export_id_; }

    /**
     * Function owner thread
     */
    ResourceHandle<EngineThread> recv() const { return recv_; }
private:
    uint32_t index_;
    size_t export_id_;
    Thread* thread_;
    ResourceHandle<EngineThread> recv_;
};

} // namespace rt
