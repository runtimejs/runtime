#define _XOPEN_SOURCE 600
#define EASTL_USER_DEFINED_ALLOCATOR // Must declare this to avoid new[]/delete[] prototypes in allocator.h
#define EASTL_ALLOCATOR_DEFAULT_NAME "SimpleAlloc"
#define EASTLAllocatorType CustomAllocator::allocator
#define EASTLAllocatorDefault CustomAllocator::GetDefaultAllocator

#include <stdio.h>
#include <stdlib.h>

#include <EABase/eabase.h>
#include <EASTL/internal/config.h>

namespace CustomAllocator {

  // Define our allocator class and implement it
  class allocator
  {
  public:
    
    // Constructors
    EASTL_ALLOCATOR_EXPLICIT inline allocator(const char* EASTL_NAME(name) = EASTL_ALLOCATOR_DEFAULT_NAME)
    {
#if EASTL_NAME_ENABLED
      mpName = name;
#endif
    }
    inline allocator(const allocator& EASTL_NAME(alloc))
    {
#if EASTL_NAME_ENABLED
      mpName = alloc.mpName;
#endif
    }
    inline allocator(const allocator&, const char* EASTL_NAME(name))
    {
#if EASTL_NAME_ENABLED
      mpName = name ? name : EASTL_ALLOCATOR_DEFAULT_NAME;
#endif
    }
    
    // Assignment
    inline allocator& operator=(const allocator& EASTL_NAME(alloc))
    {
#if EASTL_NAME_ENABLED
      mpName = alloc.mpName;
#endif
      return *this; // All considered equal since they're global malloc/free
    }
    
    // Allocation & Deallocation
    inline void* allocate(size_t n, int flags = 0)
    {
#if defined(EA_DEBUG)
      printf("Malloc'ing %lu bytes\n",n);
#endif
      return ::malloc(n);
    }
    inline void* allocate(size_t n, size_t alignment, size_t offset, int flags = 0)
    {
      char* mem = NULL;
      
#if defined(EA_DEBUG)
      printf("Malloc'ing %lu bytes\n",n);
#endif
      
      posix_memalign((void**)&mem, alignment, n);
      return mem;
    }
    
    inline void deallocate(void* p, size_t n)
    {
#if defined(EA_DEBUG)
      printf("Freeing %lu bytes\n",n);
#endif
      ::free(p);
    }
    
    // Name info
    inline const char* get_name() const
    {
#if EASTL_NAME_ENABLED
      return mpName;
#else
      return EASTL_ALLOCATOR_DEFAULT_NAME;
#endif
    }
    inline void set_name(const char* EASTL_NAME(name))
    {
#if EASTL_NAME_ENABLED
      mpName = name;
#endif
    }
    
    
  private:
#if EASTL_NAME_ENABLED
    const char* mpName;
#endif
  };
  
  // EASTL expects us to define these operators (allocator.h L103)
  bool operator==(const allocator& a, const allocator& b)
  {
    return true; // All are considered equal since they are global malloc/free
  }
  bool operator!=(const allocator& a, const allocator& b)
  {
    return false; // All are considered equal since they are global malloc/free
  }
  
  // Defines the EASTL API glue, so we can set our allocator as the global default allocator
  allocator  gDefaultAllocator;
  allocator* gpDefaultAllocator = &gDefaultAllocator;
  
  allocator* GetDefaultAllocator()
  { return gpDefaultAllocator; }
  
  allocator* SetDefaultAllocator(allocator* pNewAlloc)
  {
    allocator* pOldAlloc = gpDefaultAllocator;
    gpDefaultAllocator = pNewAlloc;
    return pOldAlloc;
  }
};


// EASTL also wants us to define this (see string.h line 197)
int Vsnprintf8(char8_t* pDestination, size_t n, const char8_t* pFormat, va_list arguments)
{
#ifdef _MSC_VER
  return _vsnprintf(pDestination, n, pFormat, arguments);
#else
  return vsnprintf(pDestination, n, pFormat, arguments);
#endif
}

#include <EASTL/string.h>

int main()
{
  eastl::string str;

  str += "o";
  str += "m";
  str += "f";
  str += "g";
  EASTL_ASSERT(str == "omfg");
  return 0;
}
