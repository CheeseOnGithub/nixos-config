set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(CMAKE_C_COMPILER clang-cl CACHE FILEPATH "")
set(CMAKE_CXX_COMPILER clang-cl CACHE FILEPATH "")
set(CMAKE_LINKER lld-link CACHE FILEPATH "")
set(CMAKE_AR llvm-lib CACHE FILEPATH "")
set(CMAKE_RC_COMPILER llvm-rc CACHE FILEPATH "")

if(DEFINED ENV{XWIN})
    set(XWIN "$ENV{XWIN}")
else()
    set(XWIN "$ENV{HOME}/.xwin")
endif()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

add_compile_options(
    --target=x86_64-pc-windows-msvc
    -fuse-ld=lld-link
    -Wno-unused-command-line-argument

    -imsvc${XWIN}/crt/include
    -imsvc${XWIN}/sdk/include/ucrt
    -imsvc${XWIN}/sdk/include/um
    -imsvc${XWIN}/sdk/include/shared
)

add_link_options(
    /libpath:${XWIN}/crt/lib/x86_64
    /libpath:${XWIN}/sdk/lib/um/x86_64
    /libpath:${XWIN}/sdk/lib/ucrt/x86_64
    /machine:x64
)