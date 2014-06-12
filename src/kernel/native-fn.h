// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
    ExternalFunction(uint32_t index, size_t export_id, Isolate* isolate,
                     ResourceHandle<EngineThread> recv)
        :	NativeObjectWrapper(NativeTypeId::TYPEID_FUNCTION),
            index_(index), export_id_(export_id),
            isolate_(isolate), recv_(recv) {
        RT_ASSERT(isolate_);
    }

    /**
     * ID allocated by function impementor
     */
    uint32_t index() const { return index_; }

    /**
     * Isolate which implements function
     */
    Isolate* isolate() const { return isolate_; }

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
    Isolate* isolate_;
    ResourceHandle<EngineThread> recv_;
};

} // namespace rt
