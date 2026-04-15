---
description: 檢查 wiki 的一致性、新鮮度、連結健康
---

# /lint — 知識庫健檢

**用法**：`/lint` 或 `/lint --full` 或 `/lint wiki/concepts/`

---

## 檢查項目

### A. Frontmatter 完整性

- [ ] 所有 wiki 頁都有 `title`, `type`, `tags`, `status`, `created`, `updated`, `sources`, `summary`
- [ ] `type` 在允許枚舉裡（concept/entity/project/topic/tool/doc）
- [ ] `status` 在允許枚舉裡（stub/draft/stable）
- [ ] `sources` 不為空（除非 `status: stub` 且創建 ≤ 7 天）

### B. 連結健康

- [ ] `related:` 中的每個路徑都存在
- [ ] `sources:` 中的 `raw/...` 路徑都存在（URL 不強檢）
- [ ] 正文中的 `[[...]]` 與 `[text](path)` 都可解析
- [ ] 雙向連結一致：若 A 的 related 有 B，B 的 related 最好也有 A

### C. 新鮮度

- [ ] `status: stub` 超過 30 天未 `updated` → 提醒
- [ ] `status: draft` 超過 90 天未 `updated` → 提醒
- [ ] 整份 wiki 超過 180 天未有新頁 → 警告

### D. 一致性

- [ ] 用 summary 相似度偵測「同一主題兩頁」的重複
- [ ] 偵測明顯矛盾：A 說 X、B 說 ¬X（用 agent 判斷）
- [ ] tags 正規化建議（RoPE vs rope vs 旋轉位置編碼）

### E. 覆蓋率

- [ ] 掃 `raw/` 找高頻術語（≥ 3 檔出現）但 wiki 沒對應頁的
- [ ] 列出「最熱門但最 stub」的頁

---

## 產出格式

寫到 `docs/health-reports/YYYY-MM-DD.md`：

```markdown
---
title: "Health report 2026-04-15"
type: doc
tags: [lint, report]
status: stable
created: 2026-04-15
updated: 2026-04-15
summary: >
  lint 於 2026-04-15 檢查結果：X 個警告、Y 個錯誤、Z 個建議。
---

# Health report — 2026-04-15

## 🔴 Errors
...

## 🟠 Warnings
...

## 🟡 Suggestions
...

## 🔵 Opportunities
...
```

---

## 自動修復選項

`/lint --fix` 會嘗試自動修：

- ✅ 補缺的 `updated:` 為今日
- ✅ 雙向連結互補
- ✅ tag 正規化（需用戶確認）
- ❌ **不會自動處理**：矛盾內容、重複頁、stub 轉 draft

矛盾與重複**必須人工決定**。
