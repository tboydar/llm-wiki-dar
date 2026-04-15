---
description: 整體健檢，對整份 wiki 跑 lint 並產報告
---

# /health-check — 完整健檢

基本上 = `/lint --full` + 額外統計。

---

## 步驟

1. 跑 `/lint --full`
2. 收集統計：
   - 總頁數、依 type 分布
   - 依 status 分布（stub / draft / stable 比例）
   - 平均每頁 source 數
   - 平均每頁 related 連結數
   - 最近 7 / 30 / 90 天的變動
3. 畫一張（文字版）近 30 天活動時間序
4. 列出：
   - 最久沒更新的 10 頁
   - 最多被連結的 10 頁（=「知識中心」）
   - 最熱門但最 stub 的 10 頁（=「亟需補內容」）
5. 把結果寫到 `docs/health-reports/full-YYYY-MM-DD.md`

---

## 範例報告骨架

```markdown
---
title: "Full health check 2026-04-15"
type: doc
tags: [lint, health, report]
status: stable
created: 2026-04-15
updated: 2026-04-15
summary: >
  全庫健檢：142 頁、18% stub、平均每頁 2.3 sources。3 個 critical 問題。
---

# Full health check — 2026-04-15

## 總覽

- 總頁數：142
- 新增（過去 30 天）：+24
- 更新（過去 30 天）：+58

### 按 type

| type     | count | % stub |
|----------|-------|--------|
| concept  |   87  |  14%   |
| entity   |   32  |  22%   |
| project  |    8  |   0%   |
| topic    |   10  |  30%   |
| tool     |    5  |  20%   |

### 按 status

stub:   26  (18%)
draft:  51  (36%)
stable: 65  (46%)

## 🔴 Critical
...

## 🟠 Warnings
...

## 🏆 Top 10 most-linked
...

## 🆘 Top 10 stub-and-hot
...

## 💤 Top 10 stale
...
```
