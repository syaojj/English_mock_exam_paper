# 모의고사 문제 추출기 - 로컬 서버
$ErrorActionPreference = "SilentlyContinue"
Set-Location $PSScriptRoot

Write-Host "========================================"
Write-Host "  모의고사 문제 추출기 - 로컬 서버"
Write-Host "========================================"
Write-Host ""
Write-Host "서버 실행 후 브라우저에서 접속하세요:"
Write-Host "  http://localhost:3333/mock-exam-extractor.html"
Write-Host ""

# Python 시도 (port 3333)
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command py -ErrorAction SilentlyContinue }

if ($python) {
    Write-Host "Python으로 서버 시작 (포트 3333)..."
    & $python.Source -m http.server 3333
} else {
    Write-Host "Python이 없습니다. npx serve 시도..."
    npx --yes serve -l 3333
}
