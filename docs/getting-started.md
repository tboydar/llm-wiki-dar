---
title: "Getting Started"
type: doc
tags: [onboarding, tutorial, howto]
status: stable
created: 2026-04-15
updated: 2026-04-15
summary: >
  從 clone 到第一次成功 /ingest 的 5 分鐘上手指南，含四款 agent 工具的對應指令。
---

# Getting Started

這份指南帶你從**零**到**第一次 ingest 成功**大約 5 分鐘。

---

## 前置

你需要至少**其中一個** agent 工具：

| 工具 | 安裝 | 對應 schema |
|------|------|-------------|
| Claude Code | `npm i -g @anthropic-ai/claude-code` | `CLAUDE.md` |
| OpenCode | `curl -fsSL https://opencode.ai/install \| bash` | `AGENTS.md` |
| Windsurf | [下載 IDE](https://codeium.com/windsurf) | `.windsurfrules` |
| Codex CLI | [OpenAI Codex CLI](https://github.com/openai/codex) | `AGENTS.md` + `.codex/` |

---

## 1. Clone

```bash
git clone https://github.com/tboydar/llm-wiki-dar.git my-wiki
cd my-wiki
```

（**改名成 `my-wiki`** 這類中性名稱 — 把這個 repo 當「你的」wiki 的起點。）

---

## 2. 啟動你的 agent

### Claude Code
```bash
claude
```
它會自動讀 `CLAUDE.md` 當 project context。

### OpenCode / Codex
```bash
opencode
# 或
codex
```
會讀 `AGENTS.md`。

### Windsurf
```bash
windsurf .
```
會讀 `.windsurfrules`。

---

## 3. 跑第一次 ingest

專案已經放了一份 **示範素材** 在 `raw/inbox/` 裡（`welcome.md`）。在你的 agent 裡輸入：

```
/ingest raw/inbox/welcome.md
```

（不支援 slash command 的工具就用自然語言：**「請 ingest raw/inbox/welcome.md」**）

agent 應該會：

1. 讀這份素材
2. 在 `log.md` append 一行摘要
3. 決定這份素材提到哪些新概念
4. 為每個新概念建立 stub 頁或更新既有頁
5. 回報變動

---

## 4. 跑一次 query 驗證

```
/query 我之前看過 Karpathy 的 LLM Wiki 是什麼？
```

預期回應：引用 `[[wiki/concepts/llm-wiki-pattern.md]]`，給你該頁的重點。

如果 agent 開始編造**沒有 source 的細節**，代表 `CLAUDE.md` 沒被正確讀進 context — 檢查你是不是在 repo 根目錄啟動 agent。

---

## 5. 跑一次 lint

```
/lint
```

或本地 shell：

```bash
./scripts/lint.sh wiki/
```

預期：all checks passed。

---

## 常見問題

### Q: agent 動了 `raw/` 下的檔案怎麼辦？
A: 嚴重違反 schema。重新強調 `CLAUDE.md §5` 的規則：**raw/ 唯讀**。最壞情況 `git checkout raw/`。

### Q: `/ingest` 沒有 slash command 支援的工具怎麼辦？
A: 把 `.claude/commands/ingest.md` 的內容當 prompt 複製貼上，或直接說：「依照 .claude/commands/ingest.md 的步驟處理 raw/inbox/xxx.md」。

### Q: 怎麼把 wiki 開在 Obsidian 裡？
A: 這個 repo 已經放了最小的 `.obsidian/app.json`。直接用 Obsidian 「Open folder as vault」選這個目錄即可。`raw/` 與 `wiki/` 都會被索引。

### Q: CI 在 PR 時 fail，怎麼看錯在哪？
A: GitHub Actions 介面會顯示哪個檔案、哪個欄位有問題。本地重現：

```bash
./scripts/lint.sh wiki/
```

---

## 下一步

- 讀 [docs/philosophy.md](philosophy.md)，理解為什麼這樣設計
- 讀 [docs/workflow.md](workflow.md)，看日常 SOP
- 讀 [docs/schema.md](schema.md)，查 frontmatter 完整規範
- 丟你自己的素材進 `raw/inbox/`，開始累積真正屬於你的 wiki
