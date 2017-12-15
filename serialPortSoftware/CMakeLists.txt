cmake_minimum_required(VERSION 3.3)
project(serialPortRead)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 ${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")

find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets)
include_directories(${Qt5Widgets_INCLUDE_DIRS})
add_definitions(${Qt5Widgets_DEFINITIONS})

set(SOURCE_FILES main.cpp)
add_executable(serialPortRead ${SOURCE_FILES})
qt5_use_modules(serialPortRead Core SerialPort)
target_link_libraries(serialPortRead Qt5::Widgets)
