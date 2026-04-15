---
description: 批次編譯 raw/inbox/ 整個目錄
---

# /compile — 批次編譯

**用法**：`/compile raw/inbox/` 或 `/compile --batch --skip-depth`

基本上就是「對每個檔案跑 /ingest」，但有幾個加速選項。

---

## 模式

### Default（深度模式）

逐檔 ingest，每個檔都精讀、都產生 / 更新頁、都建連結。

**適用**：inbox 少於 5 檔。

### `--batch`（批次模式）

先全掃一遍 inbox，產生一份「**這批素材共提到的主題**」列表。然後：

1. 對每個主題建立 / 更新 wiki 頁
2. 多檔共同提到的主題會一次整合

**適用**：inbox 有 5-20 檔且主題重疊。

### `--skip-depth`（淺層模式）

- 只讀每份素材的前 200 行 + 標題
- 只建 `stub` 頁
- 不深入更新 wiki 現有頁

**適用**：inbox 累積超過 20 檔、想先把位子占好、細節之後再精修。

---

## 通用流程

```
1. 掃 inbox/  →  列出所有檔案
2. 對每個檔：
   - 產生一句摘要 → append log.md
   - 依模式處理
3. 全部處理完：
   - 把處理過的檔案 move 到 raw/<分類>/（由 agent 判斷）
   - 原地 inbox/ 只留還沒處理的
4. 產出報告
```

---

## 分類邏輯（move from inbox）

agent 看內容，決定搬到哪：

| 關鍵訊號 | 目的地 |
|---------|--------|
| 提到 LLM / agent / prompt / claude / gpt | `raw/ai-llm/` |
| 提到 k8s / docker / ci / cloud | `raw/devops/` |
| arxiv / doi / 論文格式 | `raw/papers/` |
| 其他 | `raw/general/` |

不確定時，保守：留在 inbox 並 flag。

---

## 回報範例

```
✅ compile raw/inbox/ 完成 (--batch mode)

處理檔案：12
  → raw/ai-llm/:  7
  → raw/papers/:  3
  → raw/general/: 2

wiki 變動：
  新建：5 個 concept、2 個 entity、1 個 topic
  更新：8 個既有頁
  stub：3（待精修）

log.md           +12 行
wiki/index.md    +8 項

建議：
- 3 個 stub 建議 24h 內跑 /thinking-partner 補內容
- 2 個可能重複的主題請人工確認（見 docs/health-reports/）
```
