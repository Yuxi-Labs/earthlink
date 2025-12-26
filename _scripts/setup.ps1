# Earthlink Setup Script
# Initialize development environment

Write-Host "Setting up Earthlink development environment..." -ForegroundColor Green

# Navigate to server directory
Set-Location -Path "$PSScriptRoot\..\server"

# Build and start Docker containers
Write-Host "`nBuilding Docker containers..." -ForegroundColor Cyan
docker compose build

Write-Host "`nStarting services..." -ForegroundColor Cyan
docker compose up -d

# Wait for services to be healthy
Write-Host "`nWaiting for database to be ready..." -ForegroundColor Cyan
Start-Sleep -Seconds 5

# Run database migrations
Write-Host "`nRunning database migrations..." -ForegroundColor Cyan
docker compose exec api alembic upgrade head

Write-Host "`nSetup complete! Services running at:" -ForegroundColor Green
Write-Host "  API: http://localhost:8000" -ForegroundColor Yellow
Write-Host "  ChromaDB: http://localhost:8001" -ForegroundColor Yellow
Write-Host "  PostgreSQL: localhost:5432" -ForegroundColor Yellow

Write-Host "`nUse 'docker compose logs -f' to view logs" -ForegroundColor Cyan
