cmake_minimum_required (VERSION 2.8)
project (play)
add_executable (play play.cpp)
target_link_libraries (play lua)

include_directories(/usr/local/include)
