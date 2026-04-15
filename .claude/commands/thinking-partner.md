---
description: 開放式探索對話，把結論沉澱成 wiki 頁
---

# /thinking-partner — 思考夥伴

**用法**：`/thinking-partner <question or topic>`

這個 command 跟 `/query` 的差別：

| /query | /thinking-partner |
|--------|-------------------|
| 有明確答案 | 開放式探索 |
| 答完就結束 | 答案會沉澱成 wiki 頁 |
| 嚴格 source | 允許「推論 + 標記為推論」 |

---

## 步驟

### 1. 讀相關 wiki 頁（當 context）

跟 /query 一樣先讀。

### 2. 展開討論

- 用戶提的主題可能還沒完整定義，agent 要幫忙**釐清問題**
- 可以**跨 concept 比較**、**提出假設**、**列出待驗證的 claim**
- 每個「推論」標 `[推論，待驗證]` 或 `[conjecture]`

### 3. 對話結束時，沉澱成 project 頁

把這次探索寫成一頁：

```
wiki/projects/thinking-YYYY-MM-DD-<topic>.md
```

frontmatter：

```yaml
---
title: "思考：<topic>"
type: project
tags: [thinking-session, <topic-tags>]
status: draft
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources:
  - "conversation:YYYY-MM-DD"
  - wiki/concepts/...（用到的 wiki 頁）
related:
  - ...
summary: >
  這次思考的核心問題與暫時結論。
---
```

### 4. 如果討論中出現新概念

- 在 `wiki/concepts/` 建對應 stub 頁
- 寫明「起源於 thinking-YYYY-MM-DD」

---

## 範例

````
用戶：/thinking-partner RoPE vs ALiBi vs NoPE，哪個對 long-context 最好？

agent：
讓我先讀相關頁 [[wiki/concepts/rope.md]] [[wiki/concepts/alibi.md]] ...

**初步比較**（有 source）：
- RoPE 在 context ≤ 預訓練長度內表現最好 [raw/papers/roformer.md:42]
- ALiBi 外推最穩定但精度稍差 [raw/papers/alibi.md:12]
- NoPE 在 decoder-only 中出乎意料地 competitive [raw/papers/nope.md]

**推論** [待驗證]：
- 三者的取捨可能是「**內插品質 vs 外推穩定性**」
- Mixing（如 RoPE + linear scaling）可能是實務最佳解

要不要把這段結論沉澱成 wiki/projects/thinking-2026-04-15-pe-comparison.md？

用戶：好

agent：✅ 已建立。新頁 summary：
「比較 RoPE / ALiBi / NoPE 在 long-context 的取捨，結論傾向 mixing 方案；
待驗證：YaRN / PI 是否壓過 ALiBi。」
````

---

## 禁止

- ❌ 把「推論」偽裝成「已知事實」
- ❌ 沉澱下來的 project 頁沒有 sources（至少要有 `conversation:` 標記）
- ❌ 討論過程中忘記回來沉澱（結束時一定要寫頁）
