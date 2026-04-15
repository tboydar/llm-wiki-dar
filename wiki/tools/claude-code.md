---
title: "Claude Code"
type: tool
tags: [cli, agent, anthropic, llm-tool]
status: draft
created: 2026-04-15
updated: 2026-04-15
sources:
  - https://docs.anthropic.com/claude/docs/claude-code
aliases: [claude, cc, claudecode]
related:
  - wiki/tools/opencode.md
  - wiki/tools/windsurf.md
summary: >
  Anthropic 官方 CLI，讀根層 CLAUDE.md 作為 project schema，可直接在 terminal 跑 agentic workflow。
---

# Claude Code

**Claude Code** 是 Anthropic 官方的 terminal agent CLI。啟動時會自動讀取專案根層的 `CLAUDE.md` 作為系統指令，把當前目錄當專案 context。

## 為什麼放在這個 wiki？

這個 `llm-wiki-dar` 本身就是設計成「Claude Code 友善」的——`CLAUDE.md` 是主 schema 入口、`.claude/commands/` 是 slash command 目錄。

## 取得

```bash
npm install -g @anthropic-ai/claude-code
# 或
curl -fsSL https://claude.ai/install.sh | sh
```

## 常用指令

```bash
claude                    # 互動模式
claude "/ingest raw/inbox/x.md"   # 直接跑 slash command
claude -p "查詢 RoPE"      # headless 一次性查詢
```

## 與這個 wiki 的搭配

| 動作 | 指令 |
|------|------|
| 編譯新素材 | `claude "/ingest raw/inbox/"` |
| 查詢 | `claude "/query 我之前看過 X 是什麼"` |
| 健檢 | `claude "/lint --full"` |

## 相關

- [[wiki/tools/opencode.md]] — 讀 AGENTS.md 的替代方案
- [[wiki/tools/windsurf.md]] — IDE 風格的 agent
