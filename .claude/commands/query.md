---
description: 查詢 wiki 並合成答案，每句標來源
---

# /query — 查詢流程

**用法**：`/query <question>` 或直接用自然語言提問。

---

## 步驟

### 1. 讀 wiki/index.md

先看目錄，找候選頁（按 tag、分類、標題）。

### 2. 用 frontmatter summary 過濾

讀候選頁的 frontmatter（只讀 summary，**不讀全文**），快速去掉不相關的。

### 3. 讀中選頁的完整內容

只讀最相關的 ~5 頁。讀 `sources:` 裡的 raw/ 檔案行範圍時，**用 Read tool 的 offset/limit** 避免載入整份原文。

### 4. 合成答案

**格式規則**：

- **每個事實** 標來源：`[[wiki/concepts/xxx.md]]` 或 `[raw/.../yyy.md:12-20]`
- **先給結論**、再給細節
- **不確定就明說**：「wiki 提到 A 但沒細節；或者我記得是 B，但我沒 source」
- **不要 hallucinate**：找不到就說找不到

### 5. 結尾列「可繼續探索」

```markdown
---
相關頁：
- [[wiki/concepts/rope.md]]
- [[wiki/topics/position-encoding.md]]

建議下一步：
- /thinking-partner 比較 RoPE vs ALiBi
- /ingest 更多論文補足 NoPE 分支
```

---

## 回答範本

````markdown
**結論**：RoPE 是 RoFormer (Su et al. 2021) 提出的位置編碼方式，
用 2D 旋轉矩陣乘進 query/key 而非加到 embedding `[[wiki/concepts/rope.md]]`。

**細節**：
- 每個 attention head 的 q_i, k_j 會先被一個角度為 `θ_i`、`θ_j` 的旋轉矩陣作用，
  使得 `<q_i, k_j>` 只依賴於 `i - j` `[raw/papers/roformer-2021.md:42-55]`
- LLaMA 1/2/3、Qwen、Mistral 都採用它 `[[wiki/entities/llama.md]]`
- 長序列外推能力優於 absolute PE，但不如 ALiBi `[[wiki/concepts/alibi.md]]`

**wiki 沒提到的**：
- RoPE 的 base (θ base) 在 long-context 下要 scale 的詳細公式 — 建議 ingest
  [YaRN 論文](https://arxiv.org/abs/2309.00071)

---
相關頁：
- [[wiki/concepts/rope.md]]
- [[wiki/topics/position-encoding.md]]
- [[wiki/entities/llama.md]]
````

---

## 禁止

- ❌ 無 source 的斷言
- ❌ 從 agent 的 pretraining 知識「補齊」wiki 沒有的東西而不標明
- ❌ 簡化到失真（複雜主題不要壓成一行）
