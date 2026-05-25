#!/usr/bin/env bash
set -e

BUILD_DIR="${BUILD_DIR:-build}"
BUILD_TYPE="${BUILD_TYPE:-Release}"

cmake -B "$BUILD_DIR" \
      -G Ninja \
      -DCMAKE_TOOLCHAIN_FILE=toolchain-msvc.cmake \
      -DCMAKE_BUILD_TYPE="$BUILD_TYPE"

cmake --build "$BUILD_DIR" --parallel

echo ""
echo "Output:"
find "$BUILD_DIR" -name "*.dll" -o -name "*.exe" | sort
