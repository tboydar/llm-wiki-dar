---
source_type: onboarding
title: "Welcome — 你的第一份素材"
date: 2026-04-15
---

# 歡迎使用 llm-wiki-dar

這是 `raw/inbox/` 目錄下的第一份素材，專門為了讓你跑通 `/ingest` 流程而存在。

---

## 關於這個 wiki

這個 wiki 採用 **Andrej Karpathy 在 2025 年提出的 LLM Wiki 模式**，核心主張是：

> **把 LLM 當成編譯器，而不是搜尋引擎。**
>
> 讓 agent 把你丟進 `raw/` 的素材「編譯」成一份持續累積、結構化的 markdown 知識樹。

傳統的 RAG（Retrieval-Augmented Generation）在每次查詢時從原始文件派生答案；而 Wiki 模式讓知識在 ingest 階段就被**一次性編譯成結構化頁面**，查詢時只需讀編譯成品。

## 三個核心角色

1. **raw/** ── 你丟進來的原始素材（文章、論文、對話紀錄），**唯讀**。
2. **wiki/** ── LLM 編譯後的結構化知識，每頁有 frontmatter（title / type / tags / status / sources / summary）。
3. **schema 檔** ── `CLAUDE.md`、`AGENTS.md`、`.windsurfrules` 等，告訴 agent 如何在兩層之間流動。

## 三個核心操作

- **ingest** ── 把 raw/ 的新素材編譯進 wiki/
- **query**  ── 從 wiki/ 讀答案，每句標來源
- **lint**   ── 定期健檢一致性、新鮮度、斷連結

## 適用的 agent

這個 wiki 同時為以下工具準備了 schema：

- Claude Code（讀 `CLAUDE.md`）
- OpenCode / Codex CLI（讀 `AGENTS.md`）
- Windsurf / Cascade（讀 `.windsurfrules`）
- GitHub Copilot（讀 `.github/copilot-instructions.md`）
- Hermes agent（讀 `agents/hermes/agent.md`）
- OpenClaw（讀 `agents/openclaw/config.md`）

---

## 你接下來會看到什麼？

如果你已經在 agent 裡跑 `/ingest raw/inbox/welcome.md`，應該會看到：

1. `log.md` 新增一行摘要
2. `wiki/concepts/llm-wiki-pattern.md` 被更新（加入這份 source 的引用）
3. 可能新建 `wiki/concepts/rag.md`（如果還沒存在）← 應該已存在
4. 可能新建 `wiki/entities/andrej-karpathy.md`
5. 回報：建立 X 頁、更新 Y 頁

---

## 參考

- [Karpathy — llm-wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [gatelynch/llm-knowledge-base](https://github.com/gatelynch/llm-knowledge-base)
