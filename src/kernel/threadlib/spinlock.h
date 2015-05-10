#pragma once

#include <stdint.h>
#include "nocopy.h"
#include "intf.h"

namespace threadlib {
  class spinlock_t {
    public:
      spinlock_t() : p_(0) {}

      void lock() {
        auto p = &p_;
        while (__sync_lock_test_and_set(p, 1)) {
          while (*p) {
            wait_pause();
          }
        }
      }

      bool try_lock() {
        auto p = &p_;
        return !__sync_lock_test_and_set(p, 1);
      }

      void unlock() {
        __sync_lock_release(&p_);
      }
    private:
      volatile uint32_t p_;
      THREAD_LIB_DELETE_COPY_AND_ASSIGN(spinlock_t);
  };
}
