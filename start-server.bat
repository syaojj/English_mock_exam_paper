@echo off
chcp 65001 >nul
echo ========================================
echo   모의고사 문제 추출기 - 로컬 서버
echo ========================================
echo.
echo 서버 시작 후 브라우저에서 접속하세요:
echo   [이 PC]  http://localhost:3333/mock-exam-extractor.html
echo   [같은 네트워크]  http://YOUR_IP:3333/mock-exam-extractor.html
echo.
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    for /f "tokens=1" %%b in ("%%a") do (
        echo   현재 IP: http://%%b:3333/mock-exam-extractor.html
        goto :ip_done
    )
)
:ip_done
echo.
cd /d "%~dp0"

REM 방법 1: Python (설치되어 있으면 권장) - 0.0.0.0으로 네트워크 접근 허용
where python >nul 2>&1
if %errorlevel% equ 0 (
    echo Python으로 서버 시작 중 (포트 3333, 네트워크 접근 허용)...
    python -m http.server 3333 --bind 0.0.0.0
    goto end
)

where py >nul 2>&1
if %errorlevel% equ 0 (
    echo Python으로 서버 시작 중 (포트 3333, 네트워크 접근 허용)...
    py -m http.server 3333 --bind 0.0.0.0
    goto end
)

REM 방법 2: npx serve
echo Python이 없습니다. npx serve를 시도합니다...
call npx --yes serve -l tcp://0.0.0.0:3333

:end
pause
