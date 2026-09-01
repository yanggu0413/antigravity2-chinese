#!/bin/bash
set -e
cd "$(dirname "$0")"

if ! command -v node &> /dev/null; then
    echo "[错误] 系统未安装 Node.js！"
    echo "请先安装 Node.js（例如：sudo apt install nodejs npm 或 sudo dnf install nodejs）"
    exit 1
fi

echo "====== 正在安装 Linux 版 Antigravity 简体中文汉化 ======"
echo "请选择左上角品牌显示方式："
echo "[1] 显示英文 Antigravity（推荐）"
echo "[2] 不显示品牌名称"
echo "[3] 显示简体中文品牌名"
printf "请输入 1/2/3，直接 Enter 默认 1："
read -r BRAND_CHOICE
BRAND_ARG="--brand-title english"
if [ "$BRAND_CHOICE" = "2" ]; then
    BRAND_ARG="--brand-title hidden"
elif [ "$BRAND_CHOICE" = "3" ]; then
    BRAND_ARG="--brand-title translated"
fi

node localization_engine.js $BRAND_ARG "$@"

if [ $? -ne 0 ]; then
    echo ""
    echo "执行失败！请检查上方错误信息。"
    exit 1
fi

echo ""
echo "处理完成！重新启动 Antigravity 即可体验简体中文界面。"
