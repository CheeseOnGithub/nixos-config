cmake_minimum_required(VERSION 3.20)
project(myproject)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(OpenGL REQUIRED)
find_package(glfw3  REQUIRED)
find_package(glm    REQUIRED)
find_package(Freetype REQUIRED)

add_executable(myproject main.cpp)

target_link_libraries(myproject PRIVATE
    OpenGL::GL
    glfw
    glm::glm
    Freetype::Freetype
)
