
#include <malloc.h>
#include <stdio.h>

// Workaround char16_t redefinition
#define EA_CHAR16_NATIVE 1

#include <EASTL/internal/config.h>

// EASTL expects us to define these, see allocator.h line 194
void* operator new[](size_t size, const char* pName, int flags,
    unsigned debugFlags, const char* file, int line)
{
    return malloc(size);
}
void* operator new[](size_t size, size_t alignment, size_t alignmentOffset,
    const char* pName, int flags, unsigned debugFlags, const char* file, int line)
{
    // this allocator doesn't support alignment
    EASTL_ASSERT(alignment <= 8);
    return malloc(size);
}

// EASTL also wants us to define this (see string.h line 197)
int Vsnprintf8(char8_t* pDestination, size_t n, const char8_t* pFormat, va_list arguments)
{
    #ifdef _MSC_VER
        return _vsnprintf(pDestination, n, pFormat, arguments);
    #else
        return vsnprintf(pDestination, n, pFormat, arguments);
    #endif
}

// Include EASTL cpp files

#include <../src/allocator.cpp>
#include <../src/assert.cpp>
#include <../src/fixed_pool.cpp>
#include <../src/hashtable.cpp>
#include <../src/red_black_tree.cpp>
#include <../src/string.cpp>

// EASTL expects 2-byte wchar_t
static_assert(sizeof(char16_t) == EA_WCHAR_SIZE, "wchar_t should be 2 bytes long.");
