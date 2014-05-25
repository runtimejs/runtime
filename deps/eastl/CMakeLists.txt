cmake_minimum_required(VERSION 2.6)

project("EASTL" CXX)

# path setting
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake_module)


# find EASTL
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
link_directories(${LIBRARY_OUTPUT_PATH})

set(EASTL_SKIP_LIBRARY_FINDING TRUE)
find_package(EASTL REQUIRED)
set(EASTL_LIBRARY EASTL)

add_definitions(${EASTL_DEFINITIONS})
include_directories(${EASTL_INCLUDE_DIR})


# create library
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/src LIB_SRCS)
add_library(${PROJECT_NAME} STATIC ${LIB_SRCS})

# test
enable_testing()

add_executable(example ${CMAKE_CURRENT_SOURCE_DIR}/contrib/example/example.cpp)
target_link_libraries(example ${EASTL_LIBRARY})
add_test(example ${EXECUTABLE_OUTPUT_PATH}/example)
add_dependencies(example EASTL)

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/test TEST_SRCS)
foreach(i ${TEST_SRCS})
  get_filename_component(name ${i} NAME_WE)
  set(name "test_${name}")

  add_executable(${name} ${i})
  target_link_libraries(${name} ${EASTL_LIBRARY})
  add_test(${name} ${EXECUTABLE_OUTPUT_PATH}/${name})

  add_dependencies(${name} EASTL)
endforeach()


# installing
install(
  DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include
  DESTINATION include
  FILES_MATCHING PATTERN "*.h")
install(TARGETS EASTL ARCHIVE DESTINATION lib)
