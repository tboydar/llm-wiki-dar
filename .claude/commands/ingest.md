---
description: 把 raw/ 下的新素材編譯進 wiki/
---

# /ingest — 素材編譯流程

**用法**：`/ingest <path>` 或 `/ingest raw/inbox/some-file.md`

**預設**：如果沒帶 path，處理 `raw/inbox/` 下**最新的一個檔案**。

---

## 步驟

### 1. 讀素材

讀 `<path>` 的完整內容。如果是 URL，先下載到 `raw/inbox/` 再繼續。

### 2. 一句話摘要 → log.md

產生 ≤ 60 字的摘要，append 到 `log.md`：

```markdown
- 2026-04-15T14:32 ingest `raw/inbox/rope-explainer.md` — RoPE 的 2D 旋轉直觀推導，含複數形式與實部虛部拆分。
```

### 3. 主題命中分析

列出這份素材**明確提到**的：

- 概念（concept）
- 實體（entity：人、公司、模型）
- 可能的新主題（topic）

**不要編造**。只列素材裡真的有出現的。

### 4. 對每個命中項

#### 4.1 若 wiki 已有對應頁

- 讀該頁
- 把新 source 加到 `sources:`
- 更新 `updated:` 為今日
- 在正文適當位置 append「新觀點」（標注 source）
- 如果新素材與既有內容**矛盾**，不要覆蓋舊的 — 加到「**分歧觀點**」章節

#### 4.2 若無對應頁

- 從 `templates/concept.md`（或 entity/topic/tool）建新頁
- `status: stub`
- 標題、tags、sources 填好
- summary 至少寫一句
- 正文**只要一段**：這個東西是什麼（1-3 句）
- 不要虛構細節 — 留給下次 ingest 或 /thinking-partner

### 5. 建立雙向連結

- 在所有新建/更新的頁的 `related:` 互加
- 在 `wiki/index.md` 的對應分類下加入新頁

### 6. 回報

```
✅ ingest 完成：raw/inbox/rope-explainer.md

log.md              +1 行
wiki/concepts/rope.md          已更新（新增 source + 「直觀推導」一段）
wiki/concepts/complex-multiplication.md   新建 stub
wiki/topics/position-encoding.md  已更新（加入 related）
wiki/index.md       +1 項

建議下一步：
- 跑 /lint 檢查新頁 frontmatter
- 或 /thinking-partner 探討 rope vs alibi
```

---

## 硬規則

- ❌ 不修改 `raw/` 下的檔案
- ❌ 不無中生有（素材沒寫的東西，別寫進 wiki）
- ❌ 不建超過 400 行的頁
- ✅ 所有新頁必須有完整 frontmatter
- ✅ 所有事實都要有 source

---

## 小技巧

- **一次 ingest 一個檔案**比一次整個 inbox 好，更不容易漏
- **大檔案**（> 5000 行）先摘要，存到 `wiki/tools/` 或 `wiki/topics/`，不要硬塞進 concept
- **PDF / EPUB** 先用 `/convert-to-md` 轉成 markdown 再 ingest
