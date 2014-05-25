#include <cassert>
#include <iostream>
#include <utility>

#include <EASTL/string.h>
#include <EASTL/vector.h>

#include "test.hpp"

#ifdef EA_COMPILER_HAS_MOVE_SEMANTICS

void move_push_back() {
  std::cout << "move_push_back:" << std::endl;

  eastl::vector<eastl::string> vec;
  vec.push_back(eastl::string("string"));
  assert(vec[0] == "string");

  std::cout << "\tsuccess!!" << std::endl;
}
void move_constructor() {
  std::cout << "move_push_back:" << std::endl;

  eastl::vector<eastl::string> vec;
  vec.insert(vec.begin(), 3, eastl::string("string"));
  assert(!vec.empty());
  assert(vec[0] == "string");

  eastl::vector<eastl::string> moved_vec = std::move(vec);
  assert(vec.empty());
  assert(!moved_vec.empty());
  assert(moved_vec[0] == "string");

  std::cout << "\tsuccess!!" << std::endl;
}

#endif

int main() {
#ifdef EA_COMPILER_HAS_MOVE_SEMANTICS
  move_push_back();
  move_constructor();
#endif
}
