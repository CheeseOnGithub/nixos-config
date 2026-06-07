#!/usr/bin/env bash
set -euo pipefail

APP_NAME="${APP_NAME:-myproject}"
OUT_DIR="${OUT_DIR:-dist}"
BUILD_MODE="${BUILD_MODE:-release}"
TARGET="${TARGET:-x86_64-pc-windows-msvc}"

export XWIN_ROOT="${XWIN_ROOT:-$HOME/.xwin}"

mkdir -p "$OUT_DIR"

case "$BUILD_MODE" in
  debug)
    cargo build --target "$TARGET"
    cp "target/$TARGET/debug/$APP_NAME.exe" "$OUT_DIR/$APP_NAME-debug.exe"
    ;;

  release)
    cargo build --release --target "$TARGET"
    cp "target/$TARGET/release/$APP_NAME.exe" "$OUT_DIR/$APP_NAME.exe"
    ;;

  *)
    echo "Unknown BUILD_MODE: $BUILD_MODE"
    echo "Use: debug, release"
    exit 1
    ;;
esac

echo ""
echo "Output:"
find "$OUT_DIR" -type f \( -name "*.exe" -o -name "*.dll" \) | sort
