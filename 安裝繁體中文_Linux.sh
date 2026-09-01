#!/bin/bash
set -e
cd "$(dirname "$0")"

# 檢查是否已安裝 Node.js
if ! command -v node &> /dev/null; then
    echo "[錯誤] 系統未安裝 Node.js！"
    echo "請先安裝 Node.js（例如：sudo apt install nodejs npm 或 sudo dnf install nodejs）"
    exit 1
fi

echo "====== 正在安裝 Linux 版 Antigravity 繁體中文在地化 ======"
echo "請選擇左上角品牌顯示方式："
echo "[1] 顯示英文 Antigravity（推薦）"
echo "[2] 不顯示品牌名稱"
echo "[3] 顯示繁體中文品牌名"
printf "請輸入 1/2/3，直接 Enter 預設 1："
read -r BRAND_CHOICE
BRAND_ARG="--brand-title english"
if [ "$BRAND_CHOICE" = "2" ]; then
    BRAND_ARG="--brand-title hidden"
elif [ "$BRAND_CHOICE" = "3" ]; then
    BRAND_ARG="--brand-title translated"
fi

node localization_engine.js --tw $BRAND_ARG "$@"

if [ $? -ne 0 ]; then
    echo ""
    echo "執行失敗！請檢查上方錯誤訊息。"
    exit 1
fi

echo ""
echo "處理完成！重新啟動 Antigravity 即可享有繁體中文介面。"
