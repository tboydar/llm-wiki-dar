# llm-wiki-dar

[![Wiki Lint](https://github.com/tboydar/llm-wiki-dar/actions/workflows/lint.yml/badge.svg)](https://github.com/tboydar/llm-wiki-dar/actions/workflows/lint.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![正體中文](https://img.shields.io/badge/lang-%E6%AD%A3%E9%AB%94%E4%B8%AD%E6%96%87-red.svg)](README.md)

> 一個由 LLM agent 協助維護的**個人知識庫**，採用 [Karpathy LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) 模式、[gatelynch/llm-knowledge-base](https://github.com/gatelynch/llm-knowledge-base) 的工作流程概念，並同時相容於 **Claude Code / Windsurf / OpenCode / GitHub Copilot / Codex / Hermes / OpenClaw** 等 agentic 工具。
>
> 內容以**正體中文**為主。
>
> 🚀 **5 分鐘上手**：[docs/getting-started.md](docs/getting-started.md)

---

## 為什麼不是 RAG？

RAG 每次查詢都從原始文件**重新派生**答案；LLM Wiki 則是讓 agent 把原始資料「**編譯**」成一份持續累積、互相連結的 markdown 知識樹。

- **RAG** ＝ 問問題才算，答完即忘
- **Wiki** ＝ 每次讀書、讀 paper、debug、寫 code，agent 都幫你更新知識樹；之後問任何問題，直接讀編譯後的成品

對於少於 ~100K tokens 的個人知識，這個模式比 RAG 更省、更準、更可追溯。

---

## 三層架構

```
raw/        ← 原始、不可變的素材（貼文、論文、對話紀錄、書摘）
wiki/       ← LLM 編譯後的結構化知識（概念頁、實體頁、主題頁）
schema 檔   ← 每個 agent 工具的「操作手冊」：CLAUDE.md / AGENTS.md / .windsurfrules ...
```

三個核心操作：

| 操作 | 什麼時候用 | 對應 slash command |
|------|-----------|--------------------|
| **ingest** | 把新素材丟進 raw/ 後 | `/ingest` |
| **query**  | 想查詢或整理知識時 | `/query` |
| **lint**   | 定期健檢知識庫 | `/lint` 或 `/health-check` |

---

## 目錄速覽

```
llm-wiki-dar/
├── raw/                    # 原始素材（不可變）
│   ├── ai-llm/              # AI / LLM / agent 相關
│   ├── devops/              # 軟體工程、DevOps、雲端
│   ├── papers/              # 論文、技術筆記
│   ├── general/             # 個人學習、通用主題
│   └── inbox/               # 剛丟進來還沒分類
│
├── wiki/                   # LLM 編譯後的知識
│   ├── index.md             # 內容索引（按分類）
│   ├── concepts/            # 概念頁（一個想法一頁）
│   ├── entities/            # 實體頁（人、組織、模型、產品）
│   ├── projects/            # 專案頁（正在做的事情）
│   ├── topics/              # 主題頁（跨概念聚合）
│   └── tools/               # 工具速查
│
├── log.md                  # 時間序流水帳（append-only）
│
├── templates/              # 新頁面模板
├── docs/                   # 設計哲學、workflow、schema
├── scripts/                # 輔助腳本
│
├── CLAUDE.md               # Claude Code schema
├── AGENTS.md               # OpenCode / Codex / 通用 agent schema
├── .windsurfrules          # Windsurf 規則
├── .github/copilot-instructions.md    # GitHub Copilot
├── .codex/config.md        # Codex CLI
├── agents/hermes/agent.md  # Hermes agent
└── agents/openclaw/config.md  # OpenClaw
```

---

## 怎麼開始？

```bash
# 1. clone
git clone https://github.com/tboydar/llm-wiki-dar.git
cd llm-wiki-dar

# 2. 選一個 agent 工具，它會自動讀對應 schema
claude                       # Claude Code 會讀 CLAUDE.md
# 或
opencode                     # 讀 AGENTS.md
# 或
windsurf .                   # 讀 .windsurfrules

# 3. 丟素材進 raw/inbox/ 然後執行 /ingest
cp ~/Downloads/some-paper.pdf raw/inbox/
# 接著在 agent 裡：/ingest raw/inbox/some-paper.pdf
```

---

## 支援的 agent 工具

所有 schema 檔都指向同一份知識庫規範（見 [docs/schema.md](docs/schema.md)）。差別只在**檔名**與**特定工具的語法細節**：

| Agent              | 設定檔                              |
|--------------------|-------------------------------------|
| Claude Code        | `CLAUDE.md`                         |
| OpenCode / opencode| `AGENTS.md`                         |
| Codex CLI          | `AGENTS.md` + `.codex/config.md`    |
| Windsurf           | `.windsurfrules`                    |
| GitHub Copilot     | `.github/copilot-instructions.md`   |
| Hermes agent       | `agents/hermes/agent.md`            |
| OpenClaw           | `agents/openclaw/config.md`         |

---

## Slash commands（可跨工具使用）

| Command | 說明 |
|---------|------|
| `/ingest`           | 處理 raw/ 的新素材，產生/更新 wiki 頁 |
| `/query`            | 查詢 wiki 並合成答案（引用來源） |
| `/lint`             | 檢查矛盾、斷連結、陳舊內容 |
| `/health-check`     | 全庫健檢報告 |
| `/compile`          | 把 raw/inbox/ 的素材編譯進 wiki |
| `/thinking-partner` | 探索式對話、腦力激盪 |

完整說明見 [.claude/commands/](.claude/commands/)。

---

## 設計哲學

- **LLM 是編譯器**：原料進、結構化知識出
- **Wiki 是持續累積的成品**：不是 chat history
- **原始資料不可變**：所有修改都在 wiki/
- **連結優於階層**：用 wikilink `[[...]]` 或相對路徑交叉引用
- **時間序與內容序並存**：`log.md` 是時間軸、`wiki/index.md` 是分類軸

詳見 [docs/philosophy.md](docs/philosophy.md)。

---

## 靈感來源

- [Andrej Karpathy — llm-wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [gatelynch/llm-knowledge-base](https://github.com/gatelynch/llm-knowledge-base)
- [aarora79/personal-knowledge-base](https://github.com/aarora79/personal-knowledge-base)
- [ScrapingArt/Karpathy-LLM-Wiki-Stack](https://github.com/ScrapingArt/Karpathy-LLM-Wiki-Stack)

---

## License

MIT
