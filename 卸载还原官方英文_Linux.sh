#!/bin/bash
set -e
cd "$(dirname "$0")"

if ! command -v node &> /dev/null; then
    echo "[错误] 系统未安装 Node.js！"
    echo "请先安装 Node.js（例如：sudo apt install nodejs npm 或 sudo dnf install nodejs）"
    exit 1
fi

echo "====== 正在卸载 Linux 版 Antigravity 汉化，恢复官方原版 ======"
node localization_engine.js --huifu "$@"

if [ $? -ne 0 ]; then
    echo ""
    echo "执行失败！请检查上方错误信息。"
    exit 1
fi

echo ""
echo "官方原版已成功恢复！"
