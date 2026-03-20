# GeoPlatform API - Quick Start Script (Windows PowerShell)
# Usage: .\start_api.ps1

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  GeoPlatform API v2.0" -ForegroundColor Cyan
Write-Host "  Quick Start Script (Windows)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check if virtual environment exists
if ((Test-Path "api/venv") -eq $false -and (Test-Path ".venv") -eq $false) {
    Write-Host "[*] Creating virtual environment..." -ForegroundColor Yellow
    python -m venv .venv
    Write-Host "[OK] Virtual environment created" -ForegroundColor Green
}

# Activate virtual environment
Write-Host "[*] Activating virtual environment..." -ForegroundColor Yellow
if (Test-Path ".venv\Scripts\Activate.ps1") {
    & ".\.venv\Scripts\Activate.ps1"
    Write-Host "[OK] Virtual environment activated" -ForegroundColor Green
} else {
    Write-Host "[ERROR] Could not find venv activation script" -ForegroundColor Red
    exit 1
}

# Install dependencies
Write-Host "[*] Installing dependencies..." -ForegroundColor Yellow
pip install -q -r api/requirements.txt
Write-Host "[OK] Dependencies installed" -ForegroundColor Green

# Check for .env file
if ((Test-Path ".env") -eq $false) {
    Write-Host ""
    Write-Host "[WARNING] .env file not found" -ForegroundColor Yellow
    Write-Host "Creating default .env (LOCAL DEVELOPMENT)" -ForegroundColor Yellow
    $envContent = @"
DATABASE_URL=postgresql://postgres:postgres@localhost:5433/geoplatform
"@
    Set-Content -Path ".env" -Value $envContent
    Write-Host "[OK] .env created with defaults" -ForegroundColor Green
}

# Display API info
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Starting GeoPlatform API v2.0" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "API will be available at:" -ForegroundColor Green
Write-Host "  - API: http://localhost:8000" -ForegroundColor White
Write-Host "  - Docs (Swagger): http://localhost:8000/docs" -ForegroundColor White
Write-Host "  - ReDoc: http://localhost:8000/redoc" -ForegroundColor White
Write-Host "  - OpenAPI JSON: http://localhost:8000/openapi.json" -ForegroundColor White
Write-Host ""
Write-Host "Test in another PowerShell terminal:" -ForegroundColor Yellow
Write-Host '  Invoke-WebRequest http://localhost:8000/health' -ForegroundColor White
Write-Host '  curl http://localhost:8000/drillholes?limit=10' -ForegroundColor White
Write-Host ""
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Start the API
Set-Location api
python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000 --log-level info
