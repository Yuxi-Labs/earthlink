# Earthlink Deployment Script
# Build and deploy to production

param(
    [string]$Environment = "production",
    [switch]$SkipBuild
)

Write-Host "Deploying Earthlink to $Environment..." -ForegroundColor Green

# Navigate to server directory
Set-Location -Path "$PSScriptRoot\..\server"

if (-not $SkipBuild) {
    Write-Host "`nBuilding production Docker images..." -ForegroundColor Cyan
    docker compose build --no-cache --build-arg BUILDKIT_INLINE_CACHE=1 api
    # Override to production target
    docker build --target prod -t earthlink-api:prod --no-cache .
}

Write-Host "`nStopping existing services..." -ForegroundColor Cyan
docker compose down

Write-Host "`nStarting services..." -ForegroundColor Cyan
docker compose up -d

Write-Host "`nRunning database migrations..." -ForegroundColor Cyan
Start-Sleep -Seconds 10  # Wait for DB to be ready
docker compose exec api alembic upgrade head

Write-Host "`nDeployment complete!" -ForegroundColor Green
Write-Host "`nService status:" -ForegroundColor Cyan
docker compose ps

Write-Host "`nAPI available at: http://localhost:8000" -ForegroundColor Yellow
