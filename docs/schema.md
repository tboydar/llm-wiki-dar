---
title: "Schema 完整規範"
type: doc
tags: [schema, reference]
status: stable
created: 2026-04-15
updated: 2026-04-15
summary: >
  所有 wiki/ 頁的 frontmatter 欄位定義、type 枚舉、status 生命週期、
  與 link 語法規則的完整說明。
---

# Schema 完整規範

## 1. 檔案類型（type）

| type       | 位置                | 用途 |
|------------|---------------------|------|
| `concept`  | `wiki/concepts/`    | 一個想法、一個術語、一個演算法 |
| `entity`   | `wiki/entities/`    | 人、組織、公司、模型、產品 |
| `project`  | `wiki/projects/`    | 進行中的事情（寫 blog、讀書計劃、side project） |
| `topic`    | `wiki/topics/`      | 聚合多個 concept 的主題頁 |
| `tool`     | `wiki/tools/`       | 工具速查（CLI、SDK、library） |
| `doc`      | `docs/`             | 元文件（這種檔案） |

---

## 2. Frontmatter 欄位

```yaml
---
title: string            # 必填。頁面標題
type: concept|entity|project|topic|tool|doc  # 必填
tags: [string]           # 必填。至少 1 個
status: stub|draft|stable  # 必填
created: YYYY-MM-DD      # 必填。建立日期
updated: YYYY-MM-DD      # 必填。最後修改日期
sources:                 # concept/entity/topic/tool 必填，stub 可留空
  - raw/path/to/file.md
  - https://...
  - "conversation:2026-04-15"
related: []              # 選填。其他 wiki 頁的相對路徑
aliases: []              # 選填。別名 / 同義詞，方便搜尋
summary: >               # 必填。≤ 80 字
  這個頁在講什麼，給 agent 快速判斷用。
---
```

### 2.1 `status` 生命週期

```
stub  →  draft  →  stable
 ↑        ↑         ↓
 └────────┴── /lint 發現過時時退回 draft
```

- **stub**：只有 frontmatter + 一句話。用來占位、記錄「我知道有這個東西」
- **draft**：有骨架、有 source，但不一定完整
- **stable**：完整、可引用、其他頁可以信任它

### 2.2 `sources` 格式

三種合法來源：

1. **相對路徑**：`raw/ai-llm/some-post.md`
   - 行範圍可選：`raw/ai-llm/some-post.md:42-55`
2. **URL**：`https://arxiv.org/abs/2104.09864`
3. **對話標記**：`conversation:YYYY-MM-DD` 或 `conversation:YYYY-MM-DD-topic`

### 2.3 `related` 格式

```yaml
related:
  - wiki/concepts/rope.md
  - wiki/entities/meta-ai.md
  - wiki/topics/position-encoding.md
```

`/lint` 會檢查每個 related 是否存在。如果目標頁有對應 related 反指，會自動提示雙向連結的一致性。

### 2.4 `tags` 建議慣例

- 小寫、連字號：`long-context`, `function-calling`
- 中英文皆可，但**同一個概念只用一種拼法**
- 常用 tag 會在 `wiki/index.md` 自動彙整

---

## 3. 連結語法

### 3.1 Wiki 內部

```markdown
詳見 [[wiki/concepts/rope.md]]
或 [RoPE](wiki/concepts/rope.md)
```

`[[...]]` 是 Obsidian 慣例；`[text](path)` 是標準 markdown。**兩者皆可**，但**單篇內統一**。

### 3.2 引用 raw

```markdown
根據 [raw/papers/roformer.md:42-55](raw/papers/roformer.md)，RoPE ...
```

### 3.3 引用外部 URL

```markdown
[Karpathy's gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
```

---

## 4. 檔名規則

- **小寫、連字號**：`rotary-position-embedding.md`
- **英文為主**，技術詞用原文
- **不用空白**、不用全形字元
- 一頁一主題，不要 `rope-and-alibi.md`（該拆成兩頁 + 一頁 topic）

---

## 5. 長度上限

- 每頁 **≤ 400 行**
- 超過就要：
  1. 抽出 sub-concept 成新頁
  2. 在原頁放 `related` 連結
  3. 重寫第一段為更高層次的綜述

---

## 6. 範例：一個完整的 concept 頁

```markdown
---
title: "Rotary Position Embedding (RoPE)"
type: concept
tags: [position-encoding, transformer, llm]
status: stable
created: 2026-03-10
updated: 2026-04-01
sources:
  - raw/papers/roformer-2021.md:1-80
  - https://arxiv.org/abs/2104.09864
related:
  - wiki/concepts/absolute-position-embedding.md
  - wiki/concepts/alibi.md
  - wiki/topics/position-encoding.md
  - wiki/entities/jianlin-su.md
aliases: [RoPE, 旋轉位置編碼]
summary: >
  一種把位置資訊以複數旋轉的形式乘進 query/key 向量的位置編碼方式，
  來源於 Su et al. 2021 RoFormer，後被 LLaMA 系列廣泛採用。
---

# Rotary Position Embedding (RoPE)

**RoPE** 是把位置資訊**乘進**（而非加進）attention 的 query/key 向量的一種位置編碼方式。
它用 2D 平面的旋轉矩陣來編碼相對位置，天然具備「相對距離」特性，在長序列外推時比
絕對位置編碼穩定 `[raw/papers/roformer-2021.md:12-30]`。

## 核心公式

...
```

---

## 7. Lint 規則索引

完整規則見 [.claude/commands/lint.md](../.claude/commands/lint.md)。
