#!/bin/bash
# GeoPlatform API - Quick Start Script (Local Development)
# Usage: bash start_api.sh

echo "=========================================="
echo "GeoPlatform API v2.0"
echo "Quick Start Script"
echo "=========================================="
echo ""

# Check if virtual environment exists
if [ ! -d "api/venv" ] && [ ! -d ".venv" ]; then
    echo "[*] Creating virtual environment..."
    python -m venv .venv
    echo "[OK] Virtual environment created"
fi

# Activate virtual environment
echo "[*] Activating virtual environment..."
if [ -f ".venv/Scripts/activate" ]; then
    source .venv/Scripts/activate  # Windows Git Bash or WSL
elif [ -f ".venv/bin/activate" ]; then
    source .venv/bin/activate  # Linux/Mac
else
    echo "[ERROR] Could not find venv activation script"
    exit 1
fi

echo "[OK] Virtual environment activated"

# Install/upgrade dependencies
echo "[*] Installing dependencies..."
pip install -q -r api/requirements.txt
echo "[OK] Dependencies installed"

# Check for .env file
if [ ! -f ".env" ]; then
    echo ""
    echo "[WARNING] .env file not found"
    echo "Creating default .env (LOCAL DEVELOPMENT)"
    cat > .env << EOF
DATABASE_URL=postgresql://postgres:postgres@localhost:5433/geoplatform
EOF
    echo "[OK] .env created with defaults"
fi

# Display API info
echo ""
echo "=========================================="
echo "Starting GeoPlatform API v2.0"
echo "=========================================="
echo ""
echo "API will be available at:"
echo "  - API: http://localhost:8000"
echo "  - Docs (Swagger): http://localhost:8000/docs"
echo "  - ReDoc: http://localhost:8000/redoc"
echo "  - OpenAPI JSON: http://localhost:8000/openapi.json"
echo ""
echo "Test in another terminal:"
echo "  curl http://localhost:8000/health"
echo "  curl http://localhost:8000/drillholes?limit=10"
echo ""
echo "Press Ctrl+C to stop the server"
echo "=========================================="
echo ""

# Start the API
cd api
uvicorn main:app --reload --host 0.0.0.0 --port 8000 --log-level info
