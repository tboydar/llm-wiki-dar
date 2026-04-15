---
title: "LLM Wiki 模式"
type: concept
tags: [llm, knowledge-management, karpathy, rag-alternative]
status: stable
created: 2026-04-15
updated: 2026-04-15
sources:
  - https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
  - https://github.com/gatelynch/llm-knowledge-base
aliases: [llm-wiki, karpathy-wiki]
related:
  - wiki/concepts/rag.md
  - wiki/topics/personal-knowledge-management.md
summary: >
  Karpathy 提出的替代 RAG 方案：由 LLM 維護一份持續累積、結構化的 markdown 知識樹，而非每次查詢都從原文派生答案。
---

# LLM Wiki 模式

**LLM Wiki 模式**是 Andrej Karpathy 在 2025 年的 gist 中提出的個人知識管理方案：把 LLM 當成**編譯器（compiler）**而不是搜尋引擎，讓 agent 把原始素材「編譯」成一份持續累積、互相連結的 markdown 知識樹。

## 與 RAG 的差異

| 面向 | RAG | LLM Wiki |
|------|-----|----------|
| 查詢時機 | 每次問都要 re-derive | 一次編譯、多次查詢 |
| 可追溯性 | top-k 黑盒 | markdown + git history |
| 累積性 | 對話結束即忘 | 持續增長的成品 |
| 適用規模 | 大型語料 | 個人 / 小團隊（≤ 100K tokens 等級） |

## 三層架構

1. **raw/**：不可變的原始素材
2. **wiki/**：LLM 編譯後的結構化知識
3. **schema 檔**（如 CLAUDE.md）：告訴 agent 如何在兩層間流動

## 三大操作

- **ingest** — 把新素材變成 wiki 頁
- **query** — 讀 wiki 合成答案
- **lint** — 檢查一致性與新鮮度

## 為什麼可行？

LLM 極擅長「機械式的書記工作」：交叉引用、一致性檢查、小範圍改寫。這些正是人類做 PKM 時最容易放棄的部分。把這些 offload 給 agent，讓人只負責「決定讀什麼、問什麼」。

## 相關

- [[wiki/concepts/rag.md]]
- [[wiki/topics/personal-knowledge-management.md]]
- [gatelynch/llm-knowledge-base](https://github.com/gatelynch/llm-knowledge-base) — 類似模式的參考實作
