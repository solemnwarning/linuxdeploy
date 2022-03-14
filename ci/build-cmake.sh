#! /bin/bash

set -e
set -x

CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v3.19.8/cmake-3.19.8.tar.gz"
CMAKE_SHA256="09b4fa4837aae55c75fb170f6a6e2b44818deba48335d1969deddfbb34e30369"
CMAKE_TAR="$(basename "$CMAKE_URL")"
CMAKE_DIR=cmake-3.19.8

INSTALL_PREFIX="$1"
INSTALL_DESTDIR="$2"

SYS_DEBIAN_ARCH=$(dpkg --print-architecture)

case "$ARCH" in
    "armhf")
        DEBIAN_ARCH=armhf

        if [ "$SYS_DEBIAN_ARCH" = "$DEBIAN_ARCH" ]
        then
            TOOLCHAIN_FILE="$(pwd)/cmake/toolchains/arm-linux-gnueabihf.cmake"
        else
            TOOLCHAIN_FILE="$(pwd)/cmake/toolchains/arm-linux-gnueabihf-cross.cmake"
            CROSS_COMPILE=1
        fi
        ;;
    "aarch64")
        DEBIAN_ARCH=arm64

        if [ "$SYS_DEBIAN_ARCH" = "$DEBIAN_ARCH" ]
        then
            TOOLCHAIN_FILE="$(pwd)/cmake/toolchains/aarch64-linux-gnu.cmake"
        else
            TOOLCHAIN_FILE="$(pwd)/cmake/toolchains/aarch64-linux-gnu-cross.cmake"
            CROSS_COMPILE=1
        fi
        ;;
    *)
        echo "Error: unsupported architecture: $ARCH"
        exit 1
        ;;
esac

if [ ! -e "$CMAKE_TAR" ]
then
	wget "$CMAKE_URL"
fi

echo "$CMAKE_SHA256 $CMAKE_TAR" > "$CMAKE_TAR.sha256sum"
sha256sum -c "$CMAKE_TAR.sha256sum"

tar -xf "$CMAKE_TAR"

cd "$CMAKE_DIR"

cmake -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -DCMAKE_USE_OPENSSL=OFF -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX"
make -j$(nproc)

if [ -z "$CROSS_COMPILE" ]
then
	# Only run tests when not cross-compiling
	make -j$(nproc) test
fi

make install DESTDIR="$INSTALL_DESTDIR"
