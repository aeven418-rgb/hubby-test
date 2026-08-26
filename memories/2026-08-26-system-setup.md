---
date: 2026-08-26
tags: [system, setup, preferences]
summary: 长期记忆系统初始化，用户偏好记录
---

## 系统设置

用户希望有一个自己控制的长期记忆库，存储和 Claude 聊天的内容，以便后续对话中可以引用。

## 记忆系统结构

- `memories/` — 按日期命名的 Markdown 文件
- `scripts/add-memory.sh` — 添加记忆
- `scripts/search-memory.sh` — 搜索记忆
- `scripts/reindex.sh` — 重建索引
- `CLAUDE.md` — Claude 行为指导

## 用户偏好

- 语言：中文优先
- 记忆格式：结构化 Markdown，含 frontmatter
