---
title: "Windsurf / Cascade"
type: tool
tags: [ide, agent, llm-tool, codeium]
status: draft
created: 2026-04-15
updated: 2026-04-15
sources:
  - https://codeium.com/windsurf
aliases: [windsurf, cascade]
related:
  - wiki/tools/claude-code.md
summary: >
  Codeium 家的 AI-native IDE，Cascade agent 會讀 .windsurfrules 當 project 指令。
---

# Windsurf / Cascade

**Windsurf** 是 Codeium 的 AI-native IDE，內建 **Cascade** agent。專案根層的 `.windsurfrules` 會被自動當作系統指令讀入。

## 為什麼放在這個 wiki？

`.windsurfrules` 在這個專案裡指向同一份 schema（[CLAUDE.md](../../CLAUDE.md)），讓你能在 Windsurf 裡做跟 Claude Code 一樣的事：ingest、query、lint。

## 使用方式

1. 打開 Windsurf，用 `File → Open Folder` 開 `llm-wiki-dar/`
2. Cascade 會自動讀 `.windsurfrules`
3. 在 Cascade chat 輸入自然語言指令，如：
   - 「幫我 ingest raw/inbox/latest.md」
   - 「查詢 wiki 裡的 RoPE 相關頁」
   - 「跑一次 lint」

## Cascade 模式對應

| 動作 | 建議模式 |
|------|---------|
| 處理 `raw/inbox/` | Write Mode |
| 查詢 wiki | Chat Mode |
| 重構 wiki 結構 | Write Mode + 多檔同步 |

## 相關

- [[wiki/tools/claude-code.md]]
- [[wiki/tools/opencode.md]]
