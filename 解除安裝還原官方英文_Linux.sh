#!/bin/bash
set -e
cd "$(dirname "$0")"

if ! command -v node &> /dev/null; then
    echo "[錯誤] 系統未安裝 Node.js！"
    echo "請先安裝 Node.js（例如：sudo apt install nodejs npm 或 sudo dnf install nodejs）"
    exit 1
fi

echo "====== 正在解除安裝 Linux 版 Antigravity 在地化，恢復官方原版 ======"
node localization_engine.js --huifu "$@"

if [ $? -ne 0 ]; then
    echo ""
    echo "執行失敗！請檢查上方錯誤訊息。"
    exit 1
fi

echo ""
echo "官方原版已成功恢復！"
