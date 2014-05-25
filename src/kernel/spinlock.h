// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <kernel/kernel.h>
#include <kernel/cpu.h>

namespace rt {

class Spinlock;

class Locker {
    friend class Spinlock;
public:
    Locker() : p(0), owner(0) { }
    ~Locker() { }
private:
    volatile uint32_t p;
    volatile uint32_t owner;
    DELETE_COPY_AND_ASSIGN(Locker);
};

class Spinlock {
public:
    Spinlock(Locker& l) : _l(&l), _p(&l.p) { }
    Spinlock(Locker* l) : _l(l), _p(&l->p) { }
    ~Spinlock() { }

    inline void lock() {
        uint32_t cpuid = Cpu::id() + 1;
        if (cpuid == _l->owner) {
            return;
        }
        while (__sync_lock_test_and_set(_p, 1)) {
            while (*_p) {
                Cpu::WaitPause();
            }
        }
        _l->owner = cpuid;
    }

    inline bool tryLock() {
        uint32_t cpuid = Cpu::id() + 1;
        if (cpuid == _l->owner) {
            return true;
        }
        bool tryresult = __sync_lock_test_and_set(_p, 1);
        if (tryresult) {
            _l->owner = cpuid;
        }
        return tryresult;
    }

    inline void unlock() {
        _l->owner = 0;
        __sync_lock_release(_p);
    }

private:
    Locker* _l;
    volatile uint32_t* _p;
    DELETE_COPY_AND_ASSIGN(Spinlock);
};

class ScopedLock {
public:
    inline ScopedLock(Locker& l)
        :	sp(l) {
        sp.lock();
    }

    inline ~ScopedLock() {
        sp.unlock();
    }
private:
    Spinlock sp;
    DELETE_COPY_AND_ASSIGN(ScopedLock);
};

template<typename T>
class LockingPtr {
public:
    LockingPtr(T* value, Locker* locker)
        :	_value(value),
            _locker(locker),
            _sp(locker) {
        _sp.lock();
    }

    ~LockingPtr() {
        _sp.unlock();
    }

    LockingPtr(LockingPtr&& l);
    T* get() const { return _value; }
    T* operator->() const { return get(); }
private:
    T* _value;
    Locker* _locker;
    Spinlock _sp;

    DELETE_COPY_AND_ASSIGN(LockingPtr);
};

} // namespace rt
