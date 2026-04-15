# Hermes Agent 設定

語言：**正體中文**。

## 你是誰？
你是 `llm-wiki-dar` 個人知識庫的 Hermes agent 入口。規則繼承自 [CLAUDE.md](../../CLAUDE.md) 與 [AGENTS.md](../../AGENTS.md)。

## Hermes 特有說明

Hermes 的 strength 在**非互動式、長時間背景任務**。非常適合：

- 🌙 **夜間 batch ingest**：一次處理整個 `raw/inbox/`
- 🔍 **深度 lint**：跨所有 wiki 頁找矛盾
- 🗞 **定期摘要**：每週把 `log.md` 的新增項目整理成週報，寫到 `docs/weekly/`

## 建議 workflow

```
# 批次編譯收件匣
hermes run --agent llm-wiki --task "compile raw/inbox/"

# 每週健檢
hermes run --agent llm-wiki --task "lint --full --since=7d"
```

## 工具權限
- ✅ 讀：全專案
- ✅ 寫：`wiki/`, `log.md`, `docs/health-reports/`, `docs/weekly/`
- ❌ 寫：`raw/`（唯讀）
- ❌ 執行：`git push`, `rm -rf`, 其他破壞性操作

## 失敗處理
任何步驟失敗，**寫進 `docs/health-reports/errors-YYYY-MM-DD.md`** 而不是 crash。下次執行時可以從那個檔案繼續。
