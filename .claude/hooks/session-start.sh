#!/usr/bin/env bash
# SessionStart hook: injects recent memory summaries into session context.

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
MEMORIES_DIR="$REPO_ROOT/memories"
RECENT_COUNT=10

recent_files=$(ls -t "$MEMORIES_DIR"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-*.md 2>/dev/null | head -n "$RECENT_COUNT")

if [[ -z "$recent_files" ]]; then
  cat <<'JSON'
{"type":"text","text":"[Memory System] No memories stored yet."}
JSON
  exit 0
fi

total=$(ls "$MEMORIES_DIR"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-*.md 2>/dev/null | wc -l | tr -d ' ')

lines="[Memory System] $total memories stored. Most recent $RECENT_COUNT:\n"
while IFS= read -r f; do
  filename="$(basename "$f")"
  date_val=$(grep '^date:' "$f" 2>/dev/null | head -1 | sed 's/date: *//')
  summary_val=$(grep '^summary:' "$f" 2>/dev/null | head -1 | sed 's/summary: *//')
  tags_val=$(grep '^tags:' "$f" 2>/dev/null | head -1 | sed 's/tags: *//')
  lines+="- [$date_val] $summary_val (tags: $tags_val, file: $filename)\n"
done <<< "$recent_files"

lines+="\nTo read a memory: cat memories/<filename>\nTo search: bash scripts/search-memory.sh <keyword>"

# Output as JSON for Claude Code hook protocol
printf '{"type":"text","text":"%s"}' "$(echo -e "$lines" | sed 's/"/\\"/g' | tr '\n' '\\n' | sed 's/\\n$//')"
