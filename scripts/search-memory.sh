#!/usr/bin/env bash
# Search memories by keyword.
# Usage: search-memory.sh <keyword> [keyword2 ...]

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MEMORIES_DIR="$REPO_ROOT/memories"

if [[ $# -eq 0 ]]; then
  echo "Usage: $0 <keyword> [keyword2 ...]"
  exit 1
fi

PATTERN="$1"
shift
for kw in "$@"; do
  PATTERN="$PATTERN|$kw"
done

echo "=== Searching memories for: $PATTERN ==="
echo ""

found=0
for f in "$MEMORIES_DIR"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-*.md; do
  [[ -f "$f" ]] || continue
  if grep -qiE "$PATTERN" "$f"; then
    filename="$(basename "$f")"
    summary=$(grep '^summary:' "$f" | head -1 | sed 's/summary: *//')
    tags=$(grep '^tags:' "$f" | head -1 | sed 's/tags: *//')
    echo "--- $filename ---"
    echo "Summary: $summary"
    echo "Tags: $tags"
    echo "Matches:"
    grep -niE "$PATTERN" "$f" | head -5 | sed 's/^/  /'
    echo ""
    found=$((found + 1))
  fi
done

if [[ $found -eq 0 ]]; then
  echo "No memories found matching: $PATTERN"
else
  echo "Found $found memory file(s)."
fi
