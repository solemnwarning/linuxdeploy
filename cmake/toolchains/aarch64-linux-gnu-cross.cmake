set(CMAKE_SYSTEM_NAME Linux CACHE STRING "" FORCE)

# which compilers to use for C and C++
set(CMAKE_C_COMPILER   aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER aarch64-linux-gnu-g++)

set(CMAKE_C_FLAGS   "-pthread" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "-pthread" CACHE STRING "" FORCE)

# where is the target environment located
set(CMAKE_FIND_ROOT_PATH  /usr/aarch64-linux-gnu/)

# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# https://gitlab.kitware.com/cmake/cmake/issues/16920#note_299077
set(THREADS_PTHREAD_ARG "2" CACHE STRING "Forcibly set by CMakeLists.txt" FORCE)
