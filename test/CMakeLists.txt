
set(CXXTEST_SOURCES
    test.cc
    test_exception.cc
    test_guard.cc
    test_typeinfo.cc
   )


add_executable(system-test ${CXXTEST_SOURCES})

# Generating excpected output with system-test
add_custom_target(test-expected-output ALL
                  COMMAND system-test > ${CMAKE_CURRENT_BINARY_DIR}/expected_output.log 2>&1
                  DEPENDS system-test)


add_executable(cxxrt-test-static ${CXXTEST_SOURCES})
set_property(TARGET cxxrt-test-static PROPERTY LINK_FLAGS -nodefaultlibs)
target_link_libraries(cxxrt-test-static cxxrt-static gcc_s pthread dl c)

add_executable(cxxrt-test-shared ${CXXTEST_SOURCES})
set_property(TARGET cxxrt-test-shared PROPERTY LINK_FLAGS -nodefaultlibs)
target_link_libraries(cxxrt-test-shared cxxrt-shared pthread dl c)

add_test(cxxrt-test-static-test
         ${CMAKE_CURRENT_SOURCE_DIR}/run_test.sh
         ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cxxrt-test-static
         ${CMAKE_CURRENT_BINARY_DIR}/expected_output.log
         ${CMAKE_CURRENT_BINARY_DIR}/test-static-output.log)

add_test(cxxrt-test-shared-test
         ${CMAKE_CURRENT_SOURCE_DIR}/run_test.sh
         ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cxxrt-test-shared
         ${CMAKE_CURRENT_BINARY_DIR}/expected_output.log
         ${CMAKE_CURRENT_BINARY_DIR}/test-shared-output.log)

set(valgrind "valgrind -q")

if(TEST_VALGRIND)
    add_test(cxxrt-test-static-test-valgrind
             ${CMAKE_CURRENT_SOURCE_DIR}/run_test.sh
             "${valgrind} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cxxrt-test-static"
             ${CMAKE_CURRENT_BINARY_DIR}/expected_output.log
             ${CMAKE_CURRENT_BINARY_DIR}/test-static-output.log)
    
    add_test(cxxrt-test-shared-test-valgrind
             ${CMAKE_CURRENT_SOURCE_DIR}/run_test.sh
             "${valgrind} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cxxrt-test-shared"
             ${CMAKE_CURRENT_BINARY_DIR}/expected_output.log
             ${CMAKE_CURRENT_BINARY_DIR}/test-shared-output.log)
endif()


# Testing with libunwind
option(TEST_LIBUNWIND "Test libcxxrt with libunwind" OFF)

if(TEST_LIBUNWIND)
    if(NOT LIBUNWIND_PATH)
        message(FATAL_ERROR "Path to libunwind should be specified. Please set LIBUNWIND_PATH variable")
    endif()

    add_executable(cxxrt-test-libunwind-static ${CXXTEST_SOURCES})
    set_property(TARGET cxxrt-test-libunwind-static PROPERTY LINK_FLAGS
                 "-L${LIBUNWIND_PATH} -nodefaultlibs")
    target_link_libraries(cxxrt-test-libunwind-static cxxrt-static
                          ${LIBUNWIND_PATH}/libunwind.a pthread gcc dl c)

    add_test(cxxrt-test-libunwind-static-test
             ${CMAKE_CURRENT_SOURCE_DIR}/run_test.sh
             ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cxxrt-test-libunwind-static
             ${CMAKE_CURRENT_BINARY_DIR}/expected_output.log
             ${CMAKE_CURRENT_BINARY_DIR}/test-libunwind-static-output.log)

    add_executable(cxxrt-test-libunwind-shared ${CXXTEST_SOURCES})
    set_property(TARGET cxxrt-test-libunwind-shared PROPERTY LINK_FLAGS
                 "-L${LIBUNWIND_PATH} -nodefaultlibs")
    target_link_libraries(cxxrt-test-libunwind-shared cxxrt-shared
                         ${LIBUNWIND_PATH}/libunwind.so  unwind pthread dl c)

    add_test(cxxrt-test-libunwind-shared-test
             ${CMAKE_CURRENT_SOURCE_DIR}/run_test.sh
             ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cxxrt-test-libunwind-shared
             ${CMAKE_CURRENT_BINARY_DIR}/expected_output.log
             ${CMAKE_CURRENT_BINARY_DIR}/test-libunwind-shared-output.log)

    if(TEST_VALGRIND)
        add_test(cxxrt-test-libunwind-static-test-valgrind
                 ${CMAKE_CURRENT_SOURCE_DIR}/run_test.sh
                 "${valgrind} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cxxrt-test-libunwind-static"
                 ${CMAKE_CURRENT_BINARY_DIR}/expected_output.log
                 ${CMAKE_CURRENT_BINARY_DIR}/test-libunwind-static-output.log)

        add_test(cxxrt-test-libunwind-shared-test-valgrind
                 ${CMAKE_CURRENT_SOURCE_DIR}/run_test.sh
                 "${valgrind} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cxxrt-test-libunwind-shared"
                 ${CMAKE_CURRENT_BINARY_DIR}/expected_output.log
                 ${CMAKE_CURRENT_BINARY_DIR}/test-libunwind-shared-output.log)
    endif()
endif()

