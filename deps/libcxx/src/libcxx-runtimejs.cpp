#include <__config>
#include <vector>

_LIBCPP_BEGIN_NAMESPACE_STD
template class __vector_base_common<true>;
_LIBCPP_END_NAMESPACE_STD

namespace std {
    exception::~exception() _NOEXCEPT
    {
    }

    const char* exception::what() const _NOEXCEPT
    {
      return "std::exception";
    }
}
