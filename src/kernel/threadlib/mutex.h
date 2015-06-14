#pragma once

#include <stdint.h>
#include "nocopy.h"
#include "spinlock.h"
#include "intf.h"

namespace threadlib {
  class mutex_t : private spinlock_t {
    public:
      mutex_t() : owner_(0), depth_(0), is_recirsive_(false) {}

      /**
       * Make this mutex recursive. It is allowed to call this method once
       * after initialization.
       */
      void set_recursive() {
        libassert(depth_ == 0 && "can not make this mutex recursive");
        is_recirsive_ = true;
      }

      void lock() {
        uint32_t thread_id = get_thread_id();
        if (is_recirsive_ && owner_ == thread_id) {
          ++depth_;
          return;
        }

        while (!spinlock_t::try_lock()) {
          sched();
        }

        owner_ = thread_id;
        ++depth_;
      }

      bool try_lock() {
        uint32_t thread_id = get_thread_id();
        if (is_recirsive_ && owner_ == thread_id) {
          ++depth_;
          return true;
        }

        if (spinlock_t::try_lock()) {
          owner_ = thread_id;
          ++depth_;
          return true;
        }

        return false;
      }

      void unlock() {
        libassert(depth_ > 0 && "trying to unlock() unlocked mutex");
        if (--depth_ == 0) {
          owner_ = 0;
          spinlock_t::unlock();
        }
      }
    private:
      uint32_t owner_;
      uint32_t depth_;
      bool is_recirsive_;
      THREAD_LIB_DELETE_COPY_AND_ASSIGN(mutex_t);
  };
}
