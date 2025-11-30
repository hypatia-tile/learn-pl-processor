#!/usr/bin/env zsh
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 \"Term Name\""
  echo "Example: $0 \"Abstract Syntax Tree\""
  exit 1
fi

TERM_NAME="$1"

# Determine repository root (fallback to current directory)
ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TERM_DIR="$ROOT_DIR/terminologies/by_name"

# Create a slug: lowercase, spaces -> '-', remove non [a-z0-9-]
SLUG="$(printf '%s' "$TERM_NAME" \
  | tr '[:upper:]' '[:lower:]' \
  | tr ' ' '-' \
  | tr -cd 'a-z0-9-')"

if [ -z "$SLUG" ]; then
  echo "Error: could not create a slug from tern name: $TERM_NAME"
  exit 1
fi

TERM_FILE="$TERM_DIR/${SLUG}.md"

mkdir -p "$TERM_DIR"

if [ -e "$TERM_FILE" ]; then
  echo "Terminology file already exists: $TERM_FILE"
else
  cat > "$TERM_FILE" <<EOF
  # ${TERM_NAME}
  ## Definition
  <!-- A precise definition of the term. -->
  ## Key Properties
  - 

  ## Example
  \`\`\`text
  <!-- Optional example illustrating the concept. -->
  \`\`\`

  ## Related Terms
  -
EOF
  
  echo "Created terminology file: $TERM_FILE"
fi
