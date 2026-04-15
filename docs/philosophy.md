---
title: "設計哲學"
type: doc
tags: [philosophy, design]
status: stable
created: 2026-04-15
updated: 2026-04-15
summary: >
  為什麼 llm-wiki 不是 RAG、也不是 chat log。它的核心主張：
  LLM 是編譯器，知識是可以被「累積」的。
---

# 設計哲學

## 1. LLM 是編譯器，不是搜尋引擎

傳統的 RAG 想法是：**每次查詢時**把相關段落抽出來，餵給 LLM 再合成答案。這種做法有三個大問題：

1. **重複勞動**：同一份知識每次問都要重新 embedding、重新檢索、重新合成
2. **黑盒難追溯**：top-k 選到什麼不可控，回答的 provenance 模糊
3. **不累積**：上次問過的 insight 下次問還要重新產生一次

LLM Wiki 的反命題：把 LLM 當成**編譯器（compiler）**。

- **輸入**：`raw/` 下的原始素材
- **編譯器**：agent（Claude Code、OpenCode、Hermes ...）
- **輸出**：`wiki/` 下結構化的 markdown 知識樹

知識從此變成一個「持續累積、可差異比對（git-diff）」的工程成品，而不是 chat history 裡易逝的雲煙。

---

## 2. Raw 與 Wiki 嚴格分離

`raw/` 是**不可變**的輸入源。任何時候你都應該能：

```bash
rm -rf wiki/
# 然後
/compile raw/
```

**再度從零重新編譯出整個 wiki/**。這保證：

- 編譯過程是可重現的
- 錯誤的 wiki 頁可以「rollback + 重新 ingest」
- 新的 agent / 新的 schema 可以隨時重新編譯

這跟軟體工程的 `src/` vs `build/` 是同一個哲學。

---

## 3. 連結優於階層

Obsidian 式的 `[[wikilink]]` 比「資料夾層級」更能描繪知識。

- 一個概念可以同時屬於多個主題 → 用 `related` frontmatter 與雙向連結表達
- 資料夾分類只是「主要歸屬」，不是唯一定義
- 查詢時 agent 應該**優先看連結圖**，再看資料夾

---

## 4. 時間序與內容序並存

人有兩種記憶取回方式：

- **時間序**：「上週三我讀到什麼？」→ 查 `log.md`
- **內容序**：「RoPE 是什麼？」→ 查 `wiki/index.md`

缺一都很痛。這也是為什麼這個 wiki 同時維護 `log.md`（append-only）與 `wiki/index.md`（按分類）。

---

## 5. 每頁都要能獨立讀懂

這是最容易被忽略但最關鍵的原則。

wiki 頁的第一段，**不看其他頁也要能讀懂**。理由：

1. 未來的 agent 只會讀 summary + 第一段就判斷要不要深入
2. 斷連結（link rot）難免發生，孤立頁也必須有生存能力
3. 你自己半年後回來看，通常只需要「那個詞大概是什麼」

---

## 6. Status 欄位是 wiki 的健康心跳

每頁都有 `status: stub | draft | stable`：

- `stub` — 只寫了一句話，占位
- `draft` — 有骨架但還沒完整
- `stable` — 可以直接引用

`/lint` 會找出「`stub` 超過 30 天未動」的頁並提醒。這防止知識庫變成「假裝結構化的 inbox」。

---

## 7. Source 是不可妥協的

**沒有 source 的 wiki 頁等於沒有**。

- 每段事實要能追回到 `raw/xxx.md` 的某行範圍
- 或 `https://...` 的原始網址
- 或 `conversation:YYYY-MM-DD` 標註對話紀錄

這讓未來的你（或 agent）能：

1. 快速判斷可信度
2. 回到原文補足 context
3. 做 cross-reference 檢查

---

## 靈感來源

- [Karpathy — llm-wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [gatelynch/llm-knowledge-base](https://github.com/gatelynch/llm-knowledge-base) — raw/wiki/brainstorming/artifacts 四層
- Vannevar Bush — *As We May Think*（1945）Memex
- Doug Engelbart — Dynamic Knowledge Repository
