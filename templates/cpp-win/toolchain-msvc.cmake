set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(CMAKE_C_COMPILER   clang-cl CACHE FILEPATH "")
set(CMAKE_CXX_COMPILER clang-cl CACHE FILEPATH "")
set(CMAKE_LINKER       lld-link CACHE FILEPATH "")
set(CMAKE_AR           llvm-lib CACHE FILEPATH "")
set(CMAKE_RC_COMPILER  llvm-rc  CACHE FILEPATH "")

if(DEFINED ENV{XWIN})
    set(XWIN "$ENV{XWIN}")
else()
    set(XWIN "$ENV{HOME}/.xwin")
endif()

set(MSVC_INCLUDE_FLAGS
        "-imsvc${XWIN}/crt/include"
        "-imsvc${XWIN}/sdk/include/ucrt"
        "-imsvc${XWIN}/sdk/include/um"
        "-imsvc${XWIN}/sdk/include/shared"
)

set(MSVC_COMPILE_FLAGS
        "-target x86_64-pc-windows-msvc"
        "-fuse-ld=lld-link"
        "-Wno-unused-command-line-argument"
        "-D_WIN64"
        "-D_WIN32"
        "-DWIN32_LEAN_AND_MEAN"
        "-D_CRT_SECURE_NO_WARNINGS"
        "-D_CRT_USE_BUILTIN_OFFSETOF"
        ${MSVC_INCLUDE_FLAGS}
)

list(JOIN MSVC_COMPILE_FLAGS " " MSVC_COMPILE_FLAGS_STR)
set(CMAKE_C_FLAGS   "${MSVC_COMPILE_FLAGS_STR}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${MSVC_COMPILE_FLAGS_STR}" CACHE STRING "" FORCE)

set(MSVC_LINK_FLAGS
        "/libpath:${XWIN}/crt/lib/x86_64"
        "/libpath:${XWIN}/sdk/lib/um/x86_64"
        "/libpath:${XWIN}/sdk/lib/ucrt/x86_64"
        "/machine:x64"
)
list(JOIN MSVC_LINK_FLAGS " " MSVC_LINK_FLAGS_STR)
set(CMAKE_EXE_LINKER_FLAGS    "${MSVC_LINK_FLAGS_STR}" CACHE STRING "" FORCE)
set(CMAKE_SHARED_LINKER_FLAGS "${MSVC_LINK_FLAGS_STR}" CACHE STRING "" FORCE)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
