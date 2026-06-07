cmake_minimum_required(VERSION 3.25)

project(myproject
    VERSION 0.1.0
    LANGUAGES C CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(BUILD_DLL "Build as DLL instead of EXE" OFF)
option(WINDOWS_SUBSYSTEM "Build EXE as Windows subsystem, no console" OFF)
option(DISABLE_GS "Disable MSVC stack security cookies" OFF)

file(GLOB_RECURSE SOURCES
    CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp"
)

file(GLOB_RECURSE HEADERS
    CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp"
)

if(BUILD_DLL)
    add_library(myproject SHARED ${SOURCES} ${HEADERS})
else()
    if(WINDOWS_SUBSYSTEM)
        add_executable(myproject WIN32 ${SOURCES} ${HEADERS})
    else()
        add_executable(myproject ${SOURCES} ${HEADERS})
    endif()
endif()

target_include_directories(myproject PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}"
    "${CMAKE_CURRENT_SOURCE_DIR}/src"
)

target_compile_definitions(myproject PRIVATE
    WIN32_LEAN_AND_MEAN
    NOMINMAX
    _CRT_SECURE_NO_WARNINGS
)

target_compile_options(myproject PRIVATE
    /W4
    /EHsc
    /permissive-
)

if(DISABLE_GS)
    target_compile_options(myproject PRIVATE /GS-)
else()
    target_compile_options(myproject PRIVATE /GS)
endif()

set_property(TARGET myproject PROPERTY
    MSVC_RUNTIME_LIBRARY "MultiThreadedDLL"
)

target_link_libraries(myproject PRIVATE
    kernel32.lib
    user32.lib
)