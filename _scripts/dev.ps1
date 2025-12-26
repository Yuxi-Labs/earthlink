# Earthlink Development Script
# Start development environment

Write-Host "Starting Earthlink development environment..." -ForegroundColor Green

# Navigate to server directory
Set-Location -Path "$PSScriptRoot\..\server"

# Start Docker containers
Write-Host "`nStarting Docker services..." -ForegroundColor Cyan
docker compose up -d

Write-Host "`nServices started:" -ForegroundColor Green
docker compose ps

Write-Host "`nFollowing logs (Ctrl+C to stop)..." -ForegroundColor Cyan
docker compose logs -f
