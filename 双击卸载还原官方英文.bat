@echo off
title Antigravity Restore Tool

echo.
echo ======================================================
echo  正在还原 Antigravity 官方原始英文状态...
echo ======================================================
echo.
echo [1/2] 正在还原官方文件...
cd /d "%~dp0"
node localization_engine.js --huifu %*

if %errorlevel% neq 0 (
    echo.
    echo [×] 还原失败，请检查上方错误信息。
    pause
    exit /b 1
)

echo.
echo [2/2] 还原完成！
echo.
echo 提示：Antigravity 已恢复为官方英文原版。
echo.
echo 窗口将在 5 秒后自动关闭...
timeout /t 5
