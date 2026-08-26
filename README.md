# hubby-test — 长期记忆库

这是一个由你自己控制的 Claude 长期记忆系统。所有记忆存储在这个 repo 里，Claude 每次对话时会自动读取。

## 目录结构

```
memories/              — 记忆文件（YYYY-MM-DD-slug.md）
  index.md             — 自动生成的索引，勿手动编辑
scripts/
  add-memory.sh        — 添加一条新记忆
  search-memory.sh     — 按关键词搜索记忆
  list-memories.sh     — 列出所有记忆（可按 tag 筛选）
  reindex.sh           — 重建 index.md
.claude/
  settings.json        — Claude Code hook 配置
  hooks/session-start.sh — 会话启动时自动注入记忆摘要
CLAUDE.md              — Claude 行为指导
```

## 快速上手

**添加记忆：**
```bash
bash scripts/add-memory.sh "slug名称" "tag1,tag2" "一句话描述" "详细内容"
```

**搜索记忆：**
```bash
bash scripts/search-memory.sh "关键词"
```

**列出所有记忆：**
```bash
bash scripts/list-memories.sh
# 按 tag 筛选：
bash scripts/list-memories.sh react
```

## 记忆文件格式

```markdown
---
date: 2026-08-26
tags: [tag1, tag2]
summary: 一句话摘要
---

正文内容...
```

## Claude 如何使用记忆

1. 每次新对话，SessionStart hook 会自动展示最近 10 条记忆摘要
2. `CLAUDE.md` 告诉 Claude：遇到"记住这个"立刻创建记忆，遇到"你还记得"先搜索记忆再回答
3. Claude 可以直接调用 `scripts/search-memory.sh` 查找相关内容
