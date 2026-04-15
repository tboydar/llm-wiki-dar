---
title: "Prompt Engineering（提示工程）"
type: concept
tags: [llm, prompt, in-context-learning]
status: stable
created: 2026-04-15
updated: 2026-04-15
sources:
  - https://www.promptingguide.ai
  - https://docs.anthropic.com/claude/docs/prompt-engineering
aliases: [prompting, 提示工程]
related:
  - wiki/concepts/agent.md
  - wiki/concepts/in-context-learning.md
  - wiki/concepts/chain-of-thought.md
summary: >
  透過系統性設計輸入文字來引導 LLM 產生期望輸出的實踐，介於「寫規格」與「哄小孩」之間的工藝。
---

# Prompt Engineering（提示工程）

**Prompt engineering** 是透過**系統性設計輸入文字**來引導 LLM 產生期望輸出的實踐。它既不是純藝術也不是純科學，而是介於「寫規格」與「跟一個聰明但健忘的實習生說話」之間的工藝。

## 核心信念

- **模型已經會做你要的事**，只是你還沒想到怎麼「叫醒」那個能力
- **小改動可能大結果**：一個詞、一個例子、一個順序調整，效果差幾十個百分點
- **具體優於抽象**：「寫得有說服力」不如「用三個 bullet、每個 ≤ 20 字、第一個是結論」

## 實務分層

從最便宜到最貴的手段：

1. **清楚的指令**：明確說要什麼格式、長度、風格
2. **Few-shot 範例**：給 2-5 個 input/output 範例
3. **Chain-of-thought**：要求模型先「想一想」再回答
4. **角色扮演（persona）**：「你是資深 X 工程師…」
5. **結構化輸出**：XML tag、JSON schema、Markdown headers
6. **Self-reflection**：回答後自我批評一輪
7. **工具呼叫**：讓模型自己決定要不要查資料

**原則**：能用低階手段解決就別用高階。越高階的手段越貴、越容易 overfitting 到特定範例。

## Anthropic 的 10 條建議（精選）

1. 用 XML tag 分隔輸入與指令
2. 給具體範例 > 給抽象描述
3. 讓 Claude「先想後答」（prefill `<thinking>`）
4. 把 system prompt 用好（不要全塞進 user turn）
5. 要求 Claude 引用原文段落（reduces hallucination）

完整 10 條見 `[https://docs.anthropic.com/claude/docs/prompt-engineering]`。

## 這個 wiki 與 prompt engineering 的關係

`CLAUDE.md`、`AGENTS.md`、`.windsurfrules` 這些檔案本質上就是**專案級 prompt engineering**——它們是每次對話的 system prompt。把時間花在這些檔案上的投資報酬率，遠高於單次對話中的 prompt 調整。

## 誤區

- ❌ **把 prompt 當銀彈**：解不了的問題有時是模型能力問題
- ❌ **無止境調整**：prompt 的邊際效益遞減很快，該切模型就切
- ❌ **複製別人的神咒**：同一個 prompt 在不同任務效果差很多
- ❌ **不做 eval**：沒有 eval 就不知道改動是變好還是變壞

## 相關

- [[wiki/concepts/agent.md]]
- [[wiki/concepts/in-context-learning.md]]
- [[wiki/concepts/chain-of-thought.md]]
- [Prompting Guide](https://www.promptingguide.ai)
- [Anthropic prompt engineering docs](https://docs.anthropic.com/claude/docs/prompt-engineering)
