# Long-Term Memory System

This repository is a personal memory store. Always follow these rules at the start of every session.

## On Session Start

1. Read `memories/index.md` to get an overview of stored topics.
2. When the user asks about something, search `memories/` for relevant files using keywords from their message.
3. Proactively surface relevant past context when it applies to the current conversation.

## Memory File Format

Each memory lives in `memories/YYYY-MM-DD-slug.md` with this structure:

```
---
date: YYYY-MM-DD
tags: [tag1, tag2]
summary: one-line summary
---

Full content here.
```

## How to Add a Memory

Use the script: `bash scripts/add-memory.sh "slug" "tags" "summary" "content"`

Or create a file manually following the format above, then run `bash scripts/reindex.sh` to update the index.

## How to Search

Run: `bash scripts/search-memory.sh "keyword"`

Or grep directly: `grep -rl "keyword" memories/`

## Rules

- Never delete memories without explicit user confirmation.
- When the user says "remember this" or "记住", create a memory immediately.
- When the user asks "do you remember" or "你还记得", search memories first before answering.
