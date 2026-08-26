#!/usr/bin/env bash
# Usage: add-memory.sh <slug> <tags-comma-separated> <summary> [content]
# Example: add-memory.sh "react-hooks" "react,frontend" "Notes on React hooks usage"

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MEMORIES_DIR="$REPO_ROOT/memories"

if [[ $# -lt 3 ]]; then
  echo "Usage: $0 <slug> <tags> <summary> [content]"
  echo "  slug:    short-name-with-dashes"
  echo "  tags:    comma,separated,tags"
  echo "  summary: one-line description"
  echo "  content: (optional) body text; if omitted, opens \$EDITOR"
  exit 1
fi

SLUG="$1"
TAGS="$2"
SUMMARY="$3"
CONTENT="${4:-}"

DATE="$(date +%Y-%m-%d)"
FILENAME="${DATE}-${SLUG}.md"
FILEPATH="$MEMORIES_DIR/$FILENAME"

if [[ -f "$FILEPATH" ]]; then
  echo "Error: $FILEPATH already exists. Use a different slug or date prefix."
  exit 1
fi

# Build tag array for YAML
TAG_ARRAY="[$(echo "$TAGS" | sed 's/,/, /g')]"

cat > "$FILEPATH" <<EOF
---
date: $DATE
tags: $TAG_ARRAY
summary: $SUMMARY
---

$CONTENT
EOF

if [[ -z "$CONTENT" ]]; then
  EDITOR="${EDITOR:-vi}"
  "$EDITOR" "$FILEPATH"
fi

echo "Created: $FILEPATH"

# Rebuild index
bash "$REPO_ROOT/scripts/reindex.sh"
