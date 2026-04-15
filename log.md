# log.md — 時間軸流水帳

> append-only 的時間序紀錄。每次 ingest、lint、或重大決定都在這裡留一行。
>
> 時間戳格式：`YYYY-MM-DDTHH:MM`（當地時區即可）
>
> 條目格式：`- <timestamp> <action> <target> — <一句話>`

---

- 2026-04-15T00:00 init — 建立 llm-wiki-dar，採 Karpathy LLM Wiki 模式；支援 Claude Code / Windsurf / OpenCode / Codex / Copilot / Hermes / OpenClaw。
- 2026-04-15T00:30 seed — 新增 3 個示範 stable concept 頁：`rag.md`、`agent.md`、`prompt-engineering.md`，展示模板填滿後的風格。
- 2026-04-15T00:35 tooling — 加入 `scripts/lint.sh`（bash 版 frontmatter 驗證器）與 GitHub Actions CI workflow，push/PR 時自動檢查 wiki/ 與 docs/。
