#!/usr/bin/env bash
set -euo pipefail

APP_NAME="${APP_NAME:-myproject}"
OUT_DIR="${OUT_DIR:-dist}"
BUILD_MODE="${BUILD_MODE:-release}"

mkdir -p "$OUT_DIR"

COMMON_FLAGS=(
  -trimpath
)

case "$BUILD_MODE" in
  debug)
    GOOS=windows GOARCH=amd64 CGO_ENABLED=0 \
      go build "${COMMON_FLAGS[@]}" \
      -gcflags="all=-N -l" \
      -o "$OUT_DIR/$APP_NAME-debug.exe" .
    ;;

  release)
    GOOS=windows GOARCH=amd64 CGO_ENABLED=0 \
      go build "${COMMON_FLAGS[@]}" \
      -ldflags="-s -w" \
      -o "$OUT_DIR/$APP_NAME.exe" .
    ;;

  gui)
    GOOS=windows GOARCH=amd64 CGO_ENABLED=0 \
      go build "${COMMON_FLAGS[@]}" \
      -ldflags="-s -w -H=windowsgui" \
      -o "$OUT_DIR/$APP_NAME-gui.exe" .
    ;;

  *)
    echo "Unknown BUILD_MODE: $BUILD_MODE"
    echo "Use: debug, release, gui"
    exit 1
    ;;
esac

echo ""
echo "Output:"
find "$OUT_DIR" -type f \( -name "*.exe" -o -name "*.dll" \) | sort
