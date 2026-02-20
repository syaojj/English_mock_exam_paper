@echo off
chcp 65001 >nul
echo ========================================
echo   모의고사 문제 추출기 - 로컬 서버
echo ========================================
echo.
echo 서버 시작 후 브라우저에서 접속하세요:
echo   http://localhost:3333/mock-exam-extractor.html
echo.
cd /d "%~dp0"

REM 방법 1: Python (설치되어 있으면 권장)
where python >nul 2>&1
if %errorlevel% equ 0 (
    echo Python으로 서버 시작 중...
    python -m http.server 3333
    goto end
)

where py >nul 2>&1
if %errorlevel% equ 0 (
    echo Python으로 서버 시작 중...
    py -m http.server 3333
    goto end
)

REM 방법 2: npx serve
echo Python이 없습니다. npx serve를 시도합니다...
call npx --yes serve -l 3333

:end
pause
