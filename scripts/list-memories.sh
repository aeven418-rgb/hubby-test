#!/usr/bin/env bash
# List all memories, optionally filtered by tag.
# Usage: list-memories.sh [tag]

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MEMORIES_DIR="$REPO_ROOT/memories"

TAG_FILTER="${1:-}"

count=0
for f in "$MEMORIES_DIR"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-*.md; do
  [[ -f "$f" ]] || continue

  if [[ -n "$TAG_FILTER" ]]; then
    tags=$(grep '^tags:' "$f" | head -1)
    echo "$tags" | grep -qi "$TAG_FILTER" || continue
  fi

  filename="$(basename "$f")"
  date_val=$(grep '^date:' "$f" | head -1 | sed 's/date: *//')
  summary_val=$(grep '^summary:' "$f" | head -1 | sed 's/summary: *//')
  tags_val=$(grep '^tags:' "$f" | head -1 | sed 's/tags: *//')

  echo "$date_val  [$filename]  $summary_val  $tags_val"
  count=$((count + 1))
done

echo ""
echo "Total: $count memories${TAG_FILTER:+ tagged '$TAG_FILTER'}"
