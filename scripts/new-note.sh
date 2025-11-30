#!/usr/bin/env zsh
set -euo pipefail

# Determine repository root (fallback to current directory)
ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

NOTE_DIR="$ROOT_DIR/notebooks"
TODAY="$(date +%Y-%m-%d)"
NOTE_FILE="$NOTE_DIR/${TODAY}.md"

mkdir -p "$NOTE_DIR"

if [ -e "$NOTE_FILE" ]; then
  echo "Daily note already exists: $NOTE_FILE"
else
  cat > "$NOTE_FILE" <<EOF
# Notes - ${TODAY}

## Context

- What am I focusing on today?
- Which experiment(s) or topic(s) relate to this note?

## Learnings
-

## Questions
-

## Next Steps
-
EOF

  echo "Created daily note: $NOTE_FILE"
fi
