---
title: "RAG（Retrieval-Augmented Generation）"
type: concept
tags: [llm, retrieval, rag, information-retrieval]
status: stable
created: 2026-04-15
updated: 2026-04-15
sources:
  - https://arxiv.org/abs/2005.11401
  - https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
aliases: [RAG, Retrieval-Augmented Generation, 檢索增強生成]
related:
  - wiki/concepts/llm-wiki-pattern.md
  - wiki/topics/personal-knowledge-management.md
summary: >
  在生成答案前先從外部知識庫檢索相關段落，把檢索結果注入 prompt 再讓 LLM 合成答案的技術。
---

# RAG（Retrieval-Augmented Generation）

**RAG** 指在 LLM 生成答案**之前**，先從外部知識庫（vector DB、文件、資料庫）檢索相關段落，把檢索結果與原問題一起送進 prompt，再讓 LLM 基於這些「即時補充的 context」生成答案的技術 `[https://arxiv.org/abs/2005.11401]`。

## 為什麼需要 RAG？

LLM 的三個先天限制促成了 RAG：

1. **知識截止**：pretraining 之後的事 LLM 不知道
2. **幻覺（hallucination）**：沒 context 就可能編造
3. **context window**：一次塞不下所有知識

RAG 的解法：**需要什麼就現查**，只把相關段落放進 context。

## 典型 pipeline

```
問題
  │
  ▼
embedding 模型 → query vector
  │
  ▼
vector DB 檢索 → top-k 段落
  │
  ▼
把段落 + 原問題組成 prompt
  │
  ▼
LLM → 答案（含出處）
```

## RAG 的代價

| 代價 | 說明 |
|------|------|
| **檢索品質決定上限** | top-k 選錯，LLM 就答錯 |
| **重複勞動** | 每次問都要重跑一次 pipeline |
| **provenance 模糊** | 最終答案與原文的對應關係是黑盒 |
| **不累積** | 上次整理好的洞察下次查詢時得從零重建 |

## RAG vs LLM Wiki

這是這個知識庫存在的原因。詳見 [[wiki/concepts/llm-wiki-pattern.md]]。

| 面向 | RAG | LLM Wiki |
|------|-----|----------|
| 知識形式 | embedding + chunk | 結構化 markdown |
| 更新時機 | 即時（查詢時）| 一次（ingest 時）|
| 可讀性 | 只有 LLM 看得懂 | 人也能直接讀 |
| 累積性 | 對話結束即忘 | git diff 可追溯 |
| 適用規模 | 大型語料 | ≤ 100K tokens 的個人知識 |

**何時選 RAG**：百萬級文件、多租戶、即時性要求高
**何時選 Wiki**：個人或小團隊、100K tokens 以內、重視可追溯

## 相關

- [[wiki/concepts/llm-wiki-pattern.md]]
- [[wiki/topics/personal-knowledge-management.md]]
- [原論文 — Lewis et al. 2020](https://arxiv.org/abs/2005.11401)
