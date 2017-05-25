#pragma once

#include <stdint.h>
#include "nocopy.h"
#include "sched.h"
#include "semaphore.h"
#include "mutex.h"

namespace threadlib {
  class condvar_t {
    public:
      condvar_t() : q_(nullptr) {}

      ~condvar_t() {
        libassert(q_ == nullptr);
      }

      void wait(mutex_t* mutex) {
        condvar_node_t node;
        m_.lock();
        node.next = q_;
        q_ = &node;
        m_.unlock();

        mutex->unlock();
        node.s.wait();
        mutex->lock();
      }

      bool timed_wait(mutex_t* mutex, uint64_t max_time_microseconds) {
        condvar_node_t node;
        m_.lock();
        node.next = q_;
        q_ = &node;
        m_.unlock();

        mutex->unlock();
        bool result = node.s.timed_wait(max_time_microseconds);
        mutex->lock();

        if (!result) {
          m_.lock();
          condvar_node_t* it = q_;
          condvar_node_t* prev = nullptr;
          while (it != nullptr) {
            if (&node == it) {
              if (prev) {
                prev->next = it->next;
              } else {
                q_ = it->next;
              }
              it->next = nullptr;
              break;
            }

            prev = it;
            it = it->next;
          }
          m_.unlock();
        }

        return result;
      }

      void signal() {
        m_.lock();
        if (q_ != nullptr) {
          q_->s.signal();
          q_ = q_->next;
        }
        m_.unlock();
      }

      void broadcast() {
        m_.lock();
        while (q_ != nullptr) {
          q_->s.signal();
          q_ = q_->next;
        }
        m_.unlock();
      }
    private:
      struct condvar_node_t {
        condvar_node_t() : s(0), next(nullptr) {}
        semaphore_t s;
        condvar_node_t* next;
      };

      mutex_t m_;
      condvar_node_t* q_;
      THREAD_LIB_DELETE_COPY_AND_ASSIGN(condvar_t);
  };
}
