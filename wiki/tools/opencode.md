---
title: "OpenCode"
type: tool
tags: [cli, agent, open-source, llm-tool]
status: draft
created: 2026-04-15
updated: 2026-04-15
sources:
  - https://opencode.ai
aliases: [opencode]
related:
  - wiki/tools/claude-code.md
summary: >
  開源的 agentic CLI，遵循 AGENTS.md 標準，可切換多家 LLM provider。
---

# OpenCode

**OpenCode** 是社群驅動的開源 agentic CLI，採 **AGENTS.md** 標準讀取專案 schema。支援多家 LLM provider（Anthropic、OpenAI、本地 Ollama）。

## 為什麼放在這個 wiki？

這個 wiki 根層同時放了 `AGENTS.md`，內容與 `CLAUDE.md` 對等，讓 OpenCode 使用者也能一鍵接入。

## 取得

```bash
# 參考官方（版本可能變動）
curl -fsSL https://opencode.ai/install | bash
```

## 常用操作

```bash
opencode            # 啟動互動
opencode "ingest raw/inbox/"
opencode "query RoPE 是什麼"
```

與 `/ingest`、`/query`、`/lint` 這類 slash command 不同，OpenCode 通常用自然語言。agent 會去讀 `.claude/commands/*.md` 找對應的 prompt 當 playbook。

## 相關

- [[wiki/tools/claude-code.md]]
