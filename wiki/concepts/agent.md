---
title: "Agent（LLM Agent）"
type: concept
tags: [llm, agent, tool-use, autonomy]
status: stable
created: 2026-04-15
updated: 2026-04-15
sources:
  - https://lilianweng.github.io/posts/2023-06-23-agent/
  - https://www.anthropic.com/research/building-effective-agents
aliases: [agent, LLM agent, AI agent]
related:
  - wiki/concepts/tool-use.md
  - wiki/concepts/react-pattern.md
  - wiki/tools/claude-code.md
summary: >
  把 LLM 置於一個 loop 中，讓它根據目標自主決定下一步動作、呼叫工具、觀察結果，直到達成任務的系統。
---

# Agent（LLM Agent）

**Agent** 是一種把 LLM 置於**決策迴圈（loop）**中的系統：LLM 不再只是「輸入 → 一次輸出」，而是「觀察狀態 → 決定動作 → 執行工具 → 觀察結果 → 再決定下一步」，直到達成使用者給的目標 `[https://lilianweng.github.io/posts/2023-06-23-agent/]`。

## 一個最小可行的 agent loop

```
while not done:
    observation = env.observe()
    thought, action = llm.decide(goal, history, observation)
    if action == "done":
        done = True
    else:
        result = tools[action].run(args)
        history.append((thought, action, result))
```

## Agent 的三個核心能力

1. **規劃（planning）**：把模糊目標拆成可執行步驟
2. **工具使用（tool use）**：呼叫外部 function、API、shell
3. **記憶（memory）**：短期（context window）與長期（wiki、向量庫）

Anthropic 的研究指出：**多數「看起來像 agent」的需求，用 workflow 就夠了**；真正需要 agentic 自主性的場景其實不多 `[https://www.anthropic.com/research/building-effective-agents]`。

## Workflow vs Agent

| 面向 | Workflow | Agent |
|------|----------|-------|
| 控制流 | 預先寫好 | LLM 動態決定 |
| 可預測性 | 高 | 低 |
| 成本 | 低 | 高（多次 LLM call） |
| 適用 | 有明確步驟 | 步驟未知、需探索 |

**建議**：能用 workflow 就別用 agent。只有當你無法預先列出所有步驟時，才需要 agent。

## 常見 agent 模式

- **ReAct**：Reason + Act 交替，每步都先 think 再 do
- **Plan-and-Execute**：一開始就生一份完整計畫，再一步步執行
- **Reflexion**：做完一輪後自我批評，修正下一輪
- **Multi-agent**：多個 agent 分工（如這個 wiki 的 Hermes / OpenClaw 配置）

## 這個 wiki 的 agent 設定

- 主要 agent 工具：[[wiki/tools/claude-code.md]]、[[wiki/tools/opencode.md]]、[[wiki/tools/windsurf.md]]
- 任務分工見 [agents/hermes/agent.md](../../agents/hermes/agent.md)、[agents/openclaw/config.md](../../agents/openclaw/config.md)

## 相關

- [[wiki/concepts/tool-use.md]]
- [[wiki/concepts/react-pattern.md]]
- [Lilian Weng — LLM Powered Autonomous Agents](https://lilianweng.github.io/posts/2023-06-23-agent/)
- [Anthropic — Building effective agents](https://www.anthropic.com/research/building-effective-agents)
