#!/usr/bin/env bash
trap '' PIPE
chmod +x build.sh

set -euo pipefail

# Usage:
# ./build.sh setup    -> install Haxe/Neko and haxelibs
# ./build.sh build    -> build (runs setup if needed)

HAXE_VERSION="4.3.2"
NEKO_VERSION="2-3-0"
WORKDIR="$PWD/.haxe-build"
HAXE_TARBALL="haxe-${HAXE_VERSION}-linux64.tar.gz"
NEKO_TARBALL="neko-2.3.0-linux64.tar.gz"

mkdir -p "$WORKDIR"
cd "$WORKDIR"

download_and_extract() {
  local url="$1"
  local out="$2"
  mkdir -p "$WORKDIR"   # Ensure folder exists
  echo "Downloading $url"
  curl -L -sSf "$url" -o "$out"
  echo "Extracting $out"
  tar -xzf "$out" -C "$WORKDIR"
}

install_haxe_and_neko() {
  # Haxe tarball URL (official GitHub release)
  HAXE_URL="https://github.com/HaxeFoundation/haxe/releases/download/${HAXE_VERSION}/${HAXE_TARBALL}"
  NEKO_URL="https://github.com/HaxeFoundation/neko/releases/download/v2-3-0/neko-2.3.0-linux64.tar.gz"

  # Download & extract
  download_and_extract "$HAXE_URL" "$HAXE_TARBALL"
  download_and_extract "$NEKO_URL" "$NEKO_TARBALL"

  # Determine extracted directory names (first component of tar)
  HAXE_DIR=$(tar -tzf "$HAXE_TARBALL" | head -1 | cut -d/ -f1)
  NEKO_DIR=$(tar -tzf "$NEKO_TARBALL" | head -1 | cut -d/ -f1)

  # Add bin dirs to PATH
  export PATH="$WORKDIR/$HAXE_DIR/bin:$WORKDIR/$NEKO_DIR/bin:$PATH"

  # For shared libraries used by neko
  export LD_LIBRARY_PATH="$WORKDIR/$NEKO_DIR/lib:${LD_LIBRARY_PATH:-}"

  echo "Haxe dir: $WORKDIR/$HAXE_DIR"
  echo "Neko dir: $WORKDIR/$NEKO_DIR"
}

setup_haxelib_and_libraries() {
  # Haxelib requires a writable haxelib directory; use HOME-based path so Netlify caching can re-use it
  export HAXELIB_PATH="${HOME}/.haxelib"
  mkdir -p "$HAXELIB_PATH"

  echo "Running haxelib setup -> $HAXELIB_PATH"
  # haxelib setup uses $HAXELIB_PATH if given
  haxelib setup "$HAXELIB_PATH"

  # Install required libraries. Pin versions where appropriate.
  echo "Installing haxelibs (lime, openfl, flixel, flixel-addons, flixel-ui)"
  haxelib install lime 8.1.3 || haxelib install lime
  haxelib install openfl 9.3.2 || haxelib install openfl
  haxelib install flixel 5.8.0 || haxelib install flixel
  haxelib install flixel-addons 3.3.0 || haxelib install flixel-addons
  haxelib install flixel-ui 2.6.3 || haxelib install flixel-ui

  # Run lime setup to finish
  haxelib run lime setup
}

do_build() {
  echo "Building HTML5..."
  haxelib run lime build html5 -release
  echo "Build output should be under export/html5/bin"
}

# Main control
case "${1:-all}" in
  setup)
    install_haxe_and_neko
    setup_haxelib_and_libraries
    echo "Setup completed."
    ;;
  build)
    # If haxe binary not found, run setup first
    if ! command -v haxe >/dev/null 2>&1; then
      echo "Haxe not found; running setup first..."
      install_haxe_and_neko
      setup_haxelib_and_libraries
    else
      echo "Haxe found: $(haxe --version)"
    fi
    do_build
    ;;
  all)
    install_haxe_and_neko
    setup_haxelib_and_libraries
    do_build
    ;;
  *)
    echo "Usage: $0 {setup|build|all}"
    exit 1
    ;;
esac
