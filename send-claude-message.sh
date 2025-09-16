#!/bin/bash

# Deprecated shim for backward compatibility
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_SCRIPT="$SCRIPT_DIR/send-chatgpt-message.sh"

>&2 echo "[deprecated] Use send-chatgpt-message.sh instead of send-claude-message.sh"
exec "$TARGET_SCRIPT" "$@"
