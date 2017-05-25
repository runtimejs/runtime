#pragma once

#define THREAD_LIB_DELETE_COPY_AND_ASSIGN(TypeName) \
  TypeName(const TypeName&) = delete;               \
  TypeName& operator=(const TypeName&) = delete
