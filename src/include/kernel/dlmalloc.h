#pragma once

#include <stddef.h>

typedef void* mspace;

extern "C" mspace create_mspace(size_t capacity, int locked);
extern "C" mspace create_mspace_with_base(void* base, size_t capacity, int locked);
extern "C" int mspace_track_large_chunks(mspace msp, int enable);
extern "C" size_t destroy_mspace(mspace msp);
extern "C" void* mspace_malloc(mspace msp, size_t bytes);
extern "C" void mspace_free(mspace msp, void* mem);
extern "C" void* mspace_realloc(mspace msp, void* mem, size_t newsize);
extern "C" void* mspace_calloc(mspace msp, size_t n_elements, size_t elem_size);
extern "C" void* mspace_memalign(mspace msp, size_t alignment, size_t bytes);

extern "C" void* dlmalloc(size_t bytes);
extern "C" void dlfree(void* mem);
extern "C" void* dlrealloc(void* mem, size_t newsize);
extern "C" void* dlcalloc(size_t n_elements, size_t elem_size);
