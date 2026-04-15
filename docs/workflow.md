---
title: "日常工作流"
type: doc
tags: [workflow, howto]
status: stable
created: 2026-04-15
updated: 2026-04-15
summary: >
  llm-wiki-dar 的日常操作 SOP：
  收集素材 → ingest → 查詢 → 定期 lint。
---

# 日常工作流

## 場景 1：讀到一篇好文章

```bash
# 1. 抓下來丟進 inbox
curl -o raw/inbox/some-post.md https://example.com/post
# 或
pbpaste > raw/inbox/$(date +%Y-%m-%d)-thoughts.md

# 2. 進 agent
claude    # 或 opencode、windsurf、hermes ...

# 3. /ingest raw/inbox/some-post.md
```

agent 會：
1. 產生一句話摘要，append 到 `log.md`
2. 掃描文中關鍵概念
3. 對每個概念：建立或更新 `wiki/concepts/` 下的頁
4. 在 `wiki/index.md` 登記
5. 回報：新建 X 頁、更新 Y 頁

---

## 場景 2：想查之前讀過的東西

```
/query 我之前看過 RoPE 是什麼？
```

agent 會：
1. 讀 `wiki/index.md` 找候選頁
2. 用 frontmatter summary 過濾
3. 讀中選頁的完整內容
4. 回答，每句標來源

**正確回答範例：**

> RoPE（Rotary Position Embedding）是一種把位置訊息**旋轉**進 query/key 向量而非加到 embedding 的位置編碼方式 `[[wiki/concepts/rope.md]]`。它在長序列外推時比 absolute PE 穩定 `[raw/papers/roformer-2021.md:42-55]`。

**錯誤回答範例（會被拒絕）：**

> RoPE 是一種位置編碼，據說比較穩定。

（缺 source，會被拒。）

---

## 場景 3：一週一次的健檢

```
/lint --full
```

或對應的自然語言：

```
對整個 wiki 跑一次 lint，找出矛盾、斷連結、以及超過 30 天沒動的 stub 頁
```

產出會寫到 `docs/health-reports/YYYY-MM-DD.md`，內含：

- 🔴 **矛盾**：頁 A 說 X，頁 B 說 ¬X
- 🟠 **斷連結**：`related` 指向不存在的頁
- 🟡 **陳舊 stub**：超過 30 天未動
- 🟡 **孤立頁**：沒有任何頁引用它
- 🔵 **頻繁提及但無頁**：raw/ 多次出現但 wiki 沒有對應頁

---

## 場景 4：想用 wiki 寫篇 blog / 報告

```
/thinking-partner 我想寫一篇「RoPE vs ALiBi」的比較文，先幫我整理論點
```

agent 會把兩個概念頁交叉比對，產出草稿，寫到 `wiki/projects/` 下（因為「要寫的東西」是 project，不是 concept）。

---

## 場景 5：批次夜間整理

用 Hermes（或 cron + Claude Code headless）：

```bash
# cron: 每天凌晨 3 點
hermes run --agent llm-wiki --task "compile raw/inbox/"
```

結合 git commit：

```bash
cd llm-wiki-dar && \
  hermes run --agent llm-wiki --task "compile raw/inbox/ then git commit -am 'nightly ingest'"
```

---

## 節奏建議

| 頻率     | 動作 |
|----------|------|
| 每天     | `/ingest` 當日收到的重要素材 |
| 每週     | `/lint` + `/health-check` |
| 每月     | 回顧 `log.md`，整理成月報 |
| 每季     | 重新 compile 整個 `raw/`（檢驗可重現性） |

---

## 一個小 tip

**先把 inbox 清乾淨再加新素材。** inbox 堆太多，agent 處理時會失焦。

如果 inbox 已經堆超過 20 篇，先跑：

```
/compile raw/inbox/ --batch --skip-depth
```

讓 agent 用**淺層摘要**先把所有素材掃過一輪，產生初版頁，之後再逐篇精修。
