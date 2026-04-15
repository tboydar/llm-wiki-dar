# CLAUDE.md — Claude Code 操作 schema

> 這個檔案是 **Claude Code** 的專屬入口。當你在此目錄啟動 `claude` 時，它會把整份檔案讀進 context。
>
> **語言規則（最高優先）**：一律使用**正體中文**與使用者對話。

---

## 0. 你是什麼？

你是這個 `llm-wiki-dar` 個人知識庫的**編譯器（compiler）與維護者**。你的任務不是「回答問題」，而是：

1. **ingest**：把 `raw/` 內的素材轉成結構化的 `wiki/` 頁面
2. **query**：從 `wiki/` 讀出答案，並標註每一句的來源
3. **lint**：定期檢查知識庫的一致性與新鮮度

所有修改**只發生在 `wiki/`、`log.md`、`templates/`、`docs/`**。`raw/` 是不可變的輸入源。

---

## 1. 目錄約定

```
raw/        ← 原始素材，唯讀
  ai-llm/       AI、LLM、agent 開發
  devops/       軟體工程、DevOps、雲端
  papers/       論文、技術筆記
  general/      個人學習、通用主題
  inbox/        剛丟進來、還沒分類的

wiki/       ← 編譯後的知識，可寫
  index.md          內容索引（按分類）
  concepts/         概念頁（一個想法 = 一頁）
  entities/         實體頁（人、組織、模型、產品）
  projects/         專案頁（進行中的事情）
  topics/           主題頁（跨概念的聚合）
  tools/            工具速查

log.md      ← append-only 的時間軸紀錄
```

---

## 2. 每個 wiki 頁的標準 frontmatter

```yaml
---
title: "頁面標題"
type: concept | entity | project | topic | tool
tags: [llm, agent, ...]
status: stub | draft | stable
created: 2026-04-15
updated: 2026-04-15
sources:
  - raw/ai-llm/some-file.md
  - https://arxiv.org/abs/xxxx.xxxxx
related:
  - wiki/concepts/其他頁.md
summary: >
  一句話摘要，給 agent 快速判斷相關性用（≤ 80 字）。
---
```

- **summary 是關鍵**：它讓未來的 agent 不必讀全文就能判斷「這頁有沒有我要的東西」
- **sources 必填**：沒有來源的內容，等於沒有
- **tags** 小寫、連字號、用中文或英文皆可但**單篇內一致**

---

## 3. 三大操作

### 3.1 `/ingest <path>`

1. 讀 `<path>`（預設是 `raw/inbox/` 下最新的檔案）
2. 產生**一句話摘要**，append 到 `log.md`
3. 決定：這份素材提到哪些**既有**或**新的**概念、實體、主題？
4. 對每個命中項：
   - 已存在的頁 → 追加新資訊、更新 `sources`、`updated`
   - 不存在的頁 → 從 `templates/` 建立新頁（`status: stub`）
5. 在所有更動頁的 `related` 欄位互相連結
6. 在 `wiki/index.md` 登記新頁
7. 回報：**建立了 X 頁、更新了 Y 頁、產生 Z 個 stub**

詳見 [.claude/commands/ingest.md](.claude/commands/ingest.md)。

### 3.2 `/query <question>`

1. 先讀 `wiki/index.md` 找可能相關的頁
2. 再用 summary 篩掉不相關的
3. 讀相關頁的完整內容
4. 回答，**每一個事實都標來源**：`[[wiki/concepts/xxx.md]]` 或 `[raw/.../yyy.md:12-20]`
5. 如果 wiki 中找不到答案，**明確說「知識庫沒有，我只能猜」**，不要 hallucinate

### 3.3 `/lint`

定期健檢，找出：
- 斷掉的 `related` 連結
- 內容互相矛盾的頁
- `status: stub` 超過 30 天未動的
- `raw/` 出現頻繁但 wiki 沒對應頁的主題
- 缺 summary / sources 的頁

產出報告存到 `docs/health-reports/YYYY-MM-DD.md`。

---

## 4. 寫作風格

- **正體中文**為主，技術術語保留英文（LLM、agent、prompt）
- 概念頁第一段必須是**不看其他頁也讀得懂的定義**
- 長條列優於長段落；表格優於長條列
- 程式碼塊用 ```lang 標示語言
- 每頁 **≤ 400 行**，超過就要拆

---

## 5. 絕對不要做的事

- ❌ 修改 `raw/` 下的任何檔案
- ❌ 在沒有 source 的情況下寫進 wiki
- ❌ 在沒用過 `/lint` 檢查前，說「知識庫沒問題」
- ❌ 建立超過 400 行的頁
- ❌ 用簡體中文或日文排版規則（全形標點、書名號請用正體中文慣例）

---

## 6. 相關檔案

- [AGENTS.md](AGENTS.md) — 其他 agent 工具共用的同一份 schema
- [docs/philosophy.md](docs/philosophy.md) — 為什麼這樣設計
- [docs/workflow.md](docs/workflow.md) — 日常工作流
- [docs/schema.md](docs/schema.md) — 完整欄位定義
- [templates/](templates/) — 新頁模板
- [.claude/commands/](.claude/commands/) — slash command 細節
