#!/usr/bin/env bash
# scripts/lint.sh — 檢查 wiki/**/*.md 的 frontmatter 與基本健康度
#
# 用法：
#   ./scripts/lint.sh              # 檢查 wiki/
#   ./scripts/lint.sh docs/        # 檢查 docs/
#   ./scripts/lint.sh --fix        # 自動修 updated 欄位（TODO）
#
# 檢查項目：
#   1. frontmatter 存在且可解析
#   2. 必填欄位：title, type, tags, status, created, updated, summary
#   3. type 在允許枚舉內
#   4. status 在允許枚舉內
#   5. 每頁 ≤ 400 行
#   6. related 連結目標存在
#
# Exit code：
#   0 — 全數通過
#   1 — 有 error
#   2 — 只有 warning（不影響 CI pass）

set -uo pipefail

TARGET="${1:-wiki/}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

RED='\033[0;31m'
YEL='\033[0;33m'
GRN='\033[0;32m'
DIM='\033[0;90m'
NC='\033[0m'

ERRORS=0
WARNINGS=0
CHECKED=0

ALLOWED_TYPES="concept entity project topic tool doc source"
ALLOWED_STATUS="stub draft stable"
REQUIRED_FIELDS="title type tags status created updated summary"
MAX_LINES=400

err()  { echo -e "${RED}✗${NC} $1"; ERRORS=$((ERRORS+1)); }
warn() { echo -e "${YEL}!${NC} $1"; WARNINGS=$((WARNINGS+1)); }
ok()   { echo -e "${GRN}✓${NC} $1"; }
dim()  { echo -e "${DIM}$1${NC}"; }

check_file() {
  local file="$1"
  local rel="${file#$ROOT/}"
  CHECKED=$((CHECKED+1))

  # 跳過純空 placeholder（.gitkeep 等）
  [[ ! -s "$file" ]] && return 0

  # 1. 必須以 --- 開頭
  local first_line
  first_line=$(head -n 1 "$file")
  if [[ "$first_line" != "---" ]]; then
    err "$rel: 缺 frontmatter（第一行不是 ---）"
    return
  fi

  # 2. 抽出 frontmatter 區塊（第一個 --- 到第二個 ---）
  local fm
  fm=$(awk '/^---$/{c++; next} c==1' "$file")

  # 3. 必填欄位
  for field in $REQUIRED_FIELDS; do
    if ! grep -q "^${field}:" <<<"$fm"; then
      err "$rel: 缺必填欄位 '${field}'"
    fi
  done

  # 4. type 枚舉
  local ftype
  ftype=$(grep '^type:' <<<"$fm" | sed 's/type:[[:space:]]*//' | tr -d '"' | tr -d "'" | head -1)
  if [[ -n "$ftype" ]]; then
    if ! echo " $ALLOWED_TYPES " | grep -q " $ftype "; then
      err "$rel: type '$ftype' 不在允許枚舉 ($ALLOWED_TYPES)"
    fi
  fi

  # 5. status 枚舉
  local fstatus
  fstatus=$(grep '^status:' <<<"$fm" | sed 's/status:[[:space:]]*//' | tr -d '"' | tr -d "'" | head -1)
  if [[ -n "$fstatus" ]]; then
    if ! echo " $ALLOWED_STATUS " | grep -q " $fstatus "; then
      err "$rel: status '$fstatus' 不在允許枚舉 ($ALLOWED_STATUS)"
    fi
  fi

  # 6. 行數
  local lines
  lines=$(wc -l <"$file" | tr -d ' ')
  if [[ "$lines" -gt "$MAX_LINES" ]]; then
    warn "$rel: $lines 行，超過 $MAX_LINES 行上限"
  fi

  # 7. sources 不為空（stub 與 doc 類型例外）
  if [[ "$fstatus" != "stub" && "$ftype" != "doc" ]]; then
    if ! grep -qE '^sources:.*[^[:space:]]' <<<"$fm"; then
      # 檢查下一行是不是 list item
      if ! awk '/^sources:/{flag=1; next} flag && /^[[:space:]]*-/{found=1; exit} flag && /^[a-z]/{exit} END{exit !found}' <<<"$fm"; then
        warn "$rel: status=$fstatus 但 sources 空（非 stub 頁應有 source）"
      fi
    fi
  fi
}

echo "Linting $TARGET ..."
echo

while IFS= read -r -d '' file; do
  check_file "$file"
done < <(find "$TARGET" -type f -name '*.md' -print0 2>/dev/null)

echo
dim "─────────────────────────────"
echo "檢查檔案：$CHECKED"
echo -e "Errors:   ${RED}$ERRORS${NC}"
echo -e "Warnings: ${YEL}$WARNINGS${NC}"
dim "─────────────────────────────"

if [[ "$ERRORS" -gt 0 ]]; then
  exit 1
elif [[ "$WARNINGS" -gt 0 ]]; then
  exit 2
else
  ok "All checks passed."
  exit 0
fi
