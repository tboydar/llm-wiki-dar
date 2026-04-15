# Contributing

歡迎對 `llm-wiki-dar` 貢獻！這個 repo 既是**個人知識庫**，也是**可被其他人 fork 當起點**的模板。

---

## 兩種貢獻情境

### A. Fork 後自用
這是預期的主要用法。直接 fork → 改名 → 把 `raw/`、`wiki/`、`log.md` 清空 → 開始你自己的知識庫。**不需要 PR 回來。**

### B. 改進 scaffold / schema / agent 設定
這類 PR 會被合回 main branch，讓所有 fork 受益。常見類型：

- 修 bug、typo
- 改進 `scripts/lint.sh` 的檢查邏輯
- 加入新 agent 工具的支援（新的 schema 檔）
- 補文件（docs/）
- 更新示範頁（但**只能用公開素材**當 source）

---

## PR 規則

1. **正體中文** 為主，程式碼與技術術語保留英文。
2. 新增 wiki 頁必須通過 `./scripts/lint.sh wiki/`（CI 也會跑）。
3. 每個 PR **一個主題**，不要把 bug fix 與 feature 混在一起。
4. Commit message 用正體中文 + Conventional Commits 前綴：
   - `feat:` 新功能
   - `fix:` bug 修正
   - `docs:` 文件
   - `chore:` 雜事（升級依賴、調整設定）
5. 大改動先開 issue 討論。

---

## 不接受的 PR

- ❌ 把個人筆記塞進 `raw/` 或 `wiki/`（請放到自己的 fork）
- ❌ 簡體中文
- ❌ 任何未標 source 的 wiki 頁
- ❌ 無意義的 formatting 變動（trailing whitespace、引號樣式等）
- ❌ 加入需要 API key 或付費服務的 hard dependency

---

## 本地開發

```bash
# Clone
git clone https://github.com/tboydar/llm-wiki-dar.git
cd llm-wiki-dar

# 跑 lint
./scripts/lint.sh wiki/
./scripts/lint.sh docs/

# 測試某個 agent
claude                # 或 opencode / codex / windsurf
```

---

## 回報 bug

開 issue 時請附：
- 你用的 agent 工具與版本
- 重現步驟
- 預期 vs 實際結果
- 如果是 lint 問題，附上 `./scripts/lint.sh` 的完整輸出
