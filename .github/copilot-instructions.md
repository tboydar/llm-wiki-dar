# GitHub Copilot 指令

語言：**正體中文**。

## 專案性質
`llm-wiki-dar` 是個 LLM 維護的個人知識庫，採 Karpathy 的 llm-wiki 模式。
主要檔案是 markdown，不是程式碼。

完整規則：
- [CLAUDE.md](../CLAUDE.md) — 主 schema
- [AGENTS.md](../AGENTS.md) — 通用 agentic schema
- [docs/schema.md](../docs/schema.md) — 欄位定義

## Copilot Chat 應該做什麼？

1. **寫 wiki 頁**時：
   - 套用 [templates/](../templates/) 的 frontmatter
   - 第一段是獨立可讀的定義
   - 每句事實都標 source
   - 正體中文 + 英文技術術語

2. **自動補全**時：
   - 不要補沒有 source 的陳述
   - 不要補簡體字
   - 不要補超過 400 行的內容

3. **查詢**時：
   - 先讀 [wiki/index.md](../wiki/index.md)
   - 引用時用 `[[wiki/concepts/xxx.md]]` 格式

## 禁止
- ❌ 修改 `raw/` 下的任何檔案
- ❌ 產生無 source 的「看起來很有道理」的內容
- ❌ 簡體中文或全形英文標點
