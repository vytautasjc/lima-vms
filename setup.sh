#!/bin/bash
set -euo pipefail

# Script's directory (absolute path, resolves symlinks too)
PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)"
USER_BIN_DIR="$HOME/bin"
BIN_NAME="devvm"

if [ ! -d "$USER_BIN_DIR" ]; then
  echo "User bin directory does not exist: $USER_BIN_DIR"
  exit 0
fi

cat > "$USER_BIN_DIR/$BIN_NAME" <<EOF
#!/usr/bin/env bash
# this was generated from setup.sh
exec make -C "$PROJECT_DIR" "\$@"
EOF

chmod +x "$USER_BIN_DIR/$BIN_NAME"

echo "Wrote $BIN_NAME — uses project dir: $(realpath "$PROJECT_DIR")"
