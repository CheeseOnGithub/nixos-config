cmake_minimum_required(VERSION 3.25)
project(myproject CXX C)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


file(GLOB_RECURSE SOURCES
        CONFIGURE_DEPENDS
        "src/*.cpp"
        "main.cpp"
)

file(GLOB_RECURSE HEADERS
        CONFIGURE_DEPENDS
        "src/*.h"
        "src/*.hpp"
        "*.h"
        "*.hpp"
)

#change add_lib -> add_exe for an .exe
#add_library(myproject SHARED ${SOURCES} ${HEADERS})
 add_executable(myproject ${SOURCES} ${HEADERS})

target_include_directories(myproject PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

target_compile_options(myproject PRIVATE
        /EHsc
        /MP
        /W3
        /GS-
        /MD
)

target_link_options(myproject PRIVATE
        /DLL
        /subsystem:windows
)

target_link_libraries(myproject PRIVATE
        kernel32.lib
        user32.lib
)
