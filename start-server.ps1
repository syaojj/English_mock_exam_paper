# 모의고사 문제 추출기 - 로컬 서버
$ErrorActionPreference = "SilentlyContinue"
Set-Location $PSScriptRoot

Write-Host "========================================"
Write-Host "  모의고사 문제 추출기 - 로컬 서버"
Write-Host "========================================"
Write-Host ""
Write-Host "서버 실행 후 브라우저에서 접속하세요:"
Write-Host "  [이 PC]  http://localhost:3333/mock-exam-extractor.html"
$ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notmatch "Loopback" -and $_.IPAddress -notmatch "^169\." } | Select-Object -First 1).IPAddress
if ($ip) { Write-Host "  [같은 네트워크]  http://${ip}:3333/mock-exam-extractor.html" }
Write-Host ""

# Python 시도 (port 3333, 0.0.0.0으로 네트워크 접근 허용)
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command py -ErrorAction SilentlyContinue }

if ($python) {
    Write-Host "Python으로 서버 시작 (포트 3333, 네트워크 접근 허용)..."
    & $python.Source -m http.server 3333 --bind 0.0.0.0
} else {
    Write-Host "Python이 없습니다. npx serve 시도..."
    npx --yes serve -l tcp://0.0.0.0:3333
}
