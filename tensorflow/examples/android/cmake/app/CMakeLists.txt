#
# Copyright (C) 2016 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include(ExternalProject)
cmake_minimum_required(VERSION 3.4.1)

set(CMAKE_VERBOSE_MAKEFILE on)

get_filename_component(TF_SRC_ROOT ${CMAKE_SOURCE_DIR}/../../../../..  ABSOLUTE)
get_filename_component(SAMPLE_SRC_DIR  ${CMAKE_SOURCE_DIR}/../..  ABSOLUTE)
include_directories(${TF_SRC_ROOT})
include_directories(${CMAKE_SOURCE_DIR}/../common/include)


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -frtti -fno-exceptions -fpic -O3 -mfpu=neon -DTF_LEAN_BINARY")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--allow-multiple-definition -Wl,--whole-archive")

file(GLOB_RECURSE tensorflow_demo_sources ${SAMPLE_SRC_DIR}/jni/*.*)
add_library(tensorflow_demo SHARED ${tensorflow_demo_sources})

get_filename_component(TENSORFLOW_ROOT_DIR ../../../../.. ABSOLUTE)
set(PREBUILT_DIR ${TENSORFLOW_ROOT_DIR}/tensorflow/contrib/makefile/gen)
add_library(lib_tf STATIC IMPORTED )
set_target_properties(lib_tf PROPERTIES IMPORTED_LOCATION
        ${PREBUILT_DIR}/lib/libtensorflow-core.a)
add_library(lib_proto STATIC IMPORTED )
set_target_properties(lib_proto PROPERTIES IMPORTED_LOCATION
    ${PREBUILT_DIR}/protobuf/lib/libprotobuf.a)

target_link_libraries(tensorflow_demo
                         lib_tf
                         lib_proto
                         android
                         log
                         jnigraphics
                         m
                         atomic
                         z)
