# Codex CLI 設定

語言：**正體中文**。

## 入口
主要規則在專案根層的 [AGENTS.md](../AGENTS.md)，Codex CLI 會自動讀取它。這個檔案只放 **Codex 特有**的提示。

## Codex 工作流建議

1. **執行 shell 指令**前務必確認不會改到 `raw/`
2. **patch 模式** 優於 full-rewrite：保留既有 frontmatter 的 `created`，只更 `updated`
3. **長檔案**：超過 400 行的 wiki 頁，應該拆分而非直接編輯
4. **ingest 流程**建議：
   ```
   codex "ingest raw/inbox/xxx.md"
   ```
   它會自動跑 [.claude/commands/ingest.md](../.claude/commands/ingest.md) 裡的步驟。

## Codex 常用指令對應

| 意圖 | Codex 指令 |
|------|-----------|
| 編譯收件匣 | `codex "compile raw/inbox/"` |
| 查詢 | `codex "query 我之前讀過 X 是什麼？"` |
| 健檢 | `codex "lint wiki/"` |
| 腦力激盪 | `codex "thinking-partner 幫我想 X"` |

## 禁止
- ❌ 在 shell 階段動用 `git push --force`
- ❌ 編輯 `raw/`
- ❌ 簡體中文輸出
