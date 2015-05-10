#pragma once

namespace threadlib {
  void sched();
  void wait_pause();
  void libassert(int);
  uint32_t get_thread_id();
  uint64_t get_time_microseconds();
}
