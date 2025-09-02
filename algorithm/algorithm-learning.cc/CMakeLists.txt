cmake_minimum_required(VERSION 3.31)
project(algorithm_learning)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)

find_package(fmt)

add_subdirectory(${CMAKE_SOURCE_DIR}/chapter_string)
add_subdirectory(${CMAKE_SOURCE_DIR}/chapter_container)
add_subdirectory(${CMAKE_SOURCE_DIR}/chapter_algorithm)
