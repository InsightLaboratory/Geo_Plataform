# GEO-PLATFORM v3.0 Frontend Setup Script (Windows)
# Usage: .\web\setup.ps1

Write-Host "🌍 GeoPlatform v3.0 - Web Setup" -ForegroundColor Cyan
Write-Host ""

# Check Node.js
Write-Host "Checking Node.js..." -ForegroundColor Yellow
$nodeVersion = node --version 2>$null
if ($nodeVersion) {
    Write-Host "✓ Node.js $nodeVersion found" -ForegroundColor Green
} else {
    Write-Host "✗ Node.js not found. Please install Node.js 18+" -ForegroundColor Red
    exit 1
}

# Navigate to web directory
Push-Location web

# Install dependencies
Write-Host ""
Write-Host "Installing dependencies..." -ForegroundColor Yellow
npm install

if ($?) {
    Write-Host ""
    Write-Host "✓ Setup complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "  1. Create .env file:"
    Write-Host "     copy .env.example .env"
    Write-Host ""
    Write-Host "  2. Start development server:"
    Write-Host "     npm run dev"
    Write-Host ""
    Write-Host "  3. Open http://localhost:3000 in your browser"
    Write-Host ""
} else {
    Write-Host "✗ Installation failed" -ForegroundColor Red
    exit 1
}

Pop-Location
