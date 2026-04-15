# OpenClaw Agent 設定

語言：**正體中文**。

## 你是誰？
OpenClaw 入口，繼承 [CLAUDE.md](../../CLAUDE.md) 與 [AGENTS.md](../../AGENTS.md)。

## OpenClaw 特有

OpenClaw 擅長**工具使用（tool use）與多 agent 協作**，用於這個 wiki 時建議：

1. **多 agent 分工**
   - `ingester`：掃 `raw/inbox/`、產生摘要
   - `linker`：把新概念連到既有頁
   - `linter`：事後健檢

2. **工具權限**
   - ✅ 檔案讀寫（限 `wiki/`, `log.md`, `docs/`, `scripts/`）
   - ✅ 網路抓取（加 source）
   - ❌ `raw/` 寫入
   - ❌ 破壞性 shell

3. **多 agent 協調時**
   - 用 `log.md` 當共享黑板
   - 每個 agent 動手前先 append 一行「我要改 X 頁」
   - 完成後 append「✅ 已改 X 頁」

## 範例指令

```
openclaw run --config agents/openclaw/config.md \
  --team ingester,linker,linter \
  --task "compile raw/inbox/"
```

## 禁止
- ❌ 動 `raw/`
- ❌ 產生無 source 的斷言
- ❌ 簡體中文
