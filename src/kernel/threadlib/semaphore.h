#pragma once

#include <stdint.h>
#include "nocopy.h"
#include "intf.h"

namespace threadlib {
  class semaphore_t {
    public:
      volatile uint32_t count_;
      semaphore_t(uint32_t initial_count) : count_(initial_count) {}

      bool try_wait() {
        uint32_t count;

        while ((count = count_) > 0) {
          if (__sync_val_compare_and_swap(&count_, count, count - 1) == count) {
            return true;
          }
        }

        return false;
      }

      void wait() {
        while (!try_wait()) {
          sched();
        }
      }

      bool timed_wait(uint64_t max_time_microseconds) {
        uint64_t end_time = get_time_microseconds() + max_time_microseconds;
        while (!try_wait()) {
          if (get_time_microseconds() > end_time) {
            return false;
          }
          sched();
        }

        return true;
      }

      void signal() {
        uint32_t count;

        do {
          count = count_;
        } while (__sync_val_compare_and_swap(&count_, count, count + 1) != count);
      }
    private:
      THREAD_LIB_DELETE_COPY_AND_ASSIGN(semaphore_t);
  };
}
