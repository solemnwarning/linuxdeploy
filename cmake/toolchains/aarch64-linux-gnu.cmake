set(CMAKE_SYSTEM_NAME Linux CACHE STRING "" FORCE)

set(CMAKE_C_FLAGS   "-pthread" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "-pthread" CACHE STRING "" FORCE)

# https://gitlab.kitware.com/cmake/cmake/issues/16920#note_299077
set(THREADS_PTHREAD_ARG "2" CACHE STRING "Forcibly set by CMakeLists.txt" FORCE)
