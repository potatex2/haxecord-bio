# Claude AI through NEtlify
#!/bin/bash
set -e

# Download and extract Haxe
echo "Installing Haxe 4.3.2..."
curl -sSL https://haxe.org/download/file/4.3.2/haxe-4.3.2-linux64.tar.gz/ | tar xz

# Download and extract Neko (required for haxelib)
echo "Installing Neko 2.3.0..."
curl -sSL https://github.com/HaxeFoundation/neko/releases/download/v2-3-0/neko-2.3.0-linux64.tar.gz | tar xz

# Set up PATH - use the actual extracted directory names
HAXE_DIR=$(find . -maxdepth 1 -name "haxe*" -type d | head -1)
NEKO_DIR=$(find . -maxdepth 1 -name "neko*" -type d | head -1)

if [ -z "$HAXE_DIR" ]; then
    echo "Error: Haxe directory not found after extraction"
    exit 1
fi

if [ -z "$NEKO_DIR" ]; then
    echo "Error: Neko directory not found after extraction"
    exit 1
fi

export PATH=$PWD/$HAXE_DIR:$PWD/$NEKO_DIR:$PATH
export LD_LIBRARY_PATH=$PWD/$NEKO_DIR:$LD_LIBRARY_PATH

echo "Using Haxe directory: $HAXE_DIR"
echo "Using Neko directory: $NEKO_DIR"

# Verify Haxe installation
echo "Verifying Haxe installation..."
if ! command -v haxe &> /dev/null; then
    echo "Error: Haxe command not found in PATH"
    exit 1
fi
haxe --version

# Verify Neko installation
echo "Verifying Neko installation..."
if ! command -v neko &> /dev/null; then
    echo "Error: Neko command not found in PATH"
    exit 1
fi
neko

# Verify haxelib can run (depends on Neko)
echo "Verifying haxelib installation..."
if ! command -v haxelib &> /dev/null; then
    echo "Error: haxelib command not found in PATH"
    exit 1
fi
haxelib version

# Set up haxelib
echo "Setting up haxelib..."
mkdir -p ~/haxelib
haxelib setup ~/haxelib

# Install dependencies
echo "Installing dependencies..."
haxelib install lime
haxelib install openfl
haxelib install flixel
haxelib install flixel-ui
haxelib install flixel-addons

# Run lime setup
echo "Setting up lime..."
haxelib run lime setup

# Build the project
echo "Building project..."
haxelib run lime build html5 -release

echo "Build completed successfully!"