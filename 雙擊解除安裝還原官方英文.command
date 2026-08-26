#!/bin/bash
cd "$(dirname "$0")"

# 檢查管理員權限，若不是 root 則自動透過 sudo 提權
if [ "$EUID" -ne 0 ]; then
    echo "======================================================"
    echo " 提示：macOS 系統修改應用程式（/Applications）需要管理員權限"
    echo " 請在下方輸入您的電腦開機密碼（輸入時密碼不顯示，直接 Enter）："
    echo "======================================================"
    exec sudo bash "$0" "$@"
fi

echo "====== 正在還原 macOS 版 Antigravity 官方英文 ======"
node localization_engine.js --huifu --install-dir /Applications/Antigravity.app

if [ $? -ne 0 ]; then
    echo ""
    echo "執行失敗！請檢查上方錯誤訊息。"
    read -n 1 -s
    exit 1
fi

echo ""
echo "處理完成。視窗將在 5 秒後自動關閉（或按任意鍵立即關閉）..."
read -t 5 -n 1 -s
