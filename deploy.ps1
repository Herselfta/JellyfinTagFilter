# Jellyfin Tag Filter - Auto Deploy Script
# Deploys files to Jellyfin server wwwroot directory

param(
    [string]$JellyfinPath = "D:\JellyfinServer\wwwroot"
)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Jellyfin Tag Filter - Deploy Tool" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Files to deploy
$files = @(
    @{Name="PWA HTML"; Source="jellyfin_tag_filter_pwa.html"; Target="tag_filter_pwa.html"},
    @{Name="Manifest"; Source="tag_filter_manifest.json"; Target="tag_filter_manifest.json"}
)

# Check source files exist
$allFilesExist = $true
foreach ($file in $files) {
    $sourcePath = Join-Path $ScriptDir $file.Source
    if (-not (Test-Path $sourcePath)) {
        Write-Host "X Error: File not found: $($file.Name)" -ForegroundColor Red
        $allFilesExist = $false
    }
}

if (-not $allFilesExist) {
    exit 1
}

# Check Jellyfin directory
if (-not (Test-Path $JellyfinPath)) {
    Write-Host "X Error: Jellyfin directory not found: $JellyfinPath" -ForegroundColor Red
    Write-Host "Specify path: .\deploy.ps1 -JellyfinPath 'YOUR_PATH'" -ForegroundColor Yellow
    exit 1
}

# Check write permission
try {
    $testFile = Join-Path $JellyfinPath "test_permission.tmp"
    New-Item -ItemType File -Path $testFile -Force | Out-Null
    Remove-Item $testFile -Force
} catch {
    Write-Host "X Error: No write permission" -ForegroundColor Red
    Write-Host "Run as Administrator" -ForegroundColor Yellow
    exit 1
}

# Deploy files
Write-Host "Deploying..." -ForegroundColor Yellow
Write-Host ""

$successCount = 0
foreach ($file in $files) {
    $sourcePath = Join-Path $ScriptDir $file.Source
    $targetPath = Join-Path $JellyfinPath $file.Target
    
    try {
        Copy-Item -Path $sourcePath -Destination $targetPath -Force
        Write-Host "  [OK] $($file.Name)" -ForegroundColor Green
        $successCount++
    } catch {
        Write-Host "  [FAIL] $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""

if ($successCount -eq $files.Count) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  Deploy Successful!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    
    # Get local IP
    $ipAddress = Get-NetIPAddress -AddressFamily IPv4 | 
                  Where-Object { $_.InterfaceAlias -notlike "*Loopback*" -and $_.IPAddress -like "192.168.*" } | 
                  Select-Object -First 1 -ExpandProperty IPAddress
    
    if (-not $ipAddress) {
        $ipAddress = Get-NetIPAddress -AddressFamily IPv4 | 
                     Where-Object { $_.InterfaceAlias -notlike "*Loopback*" } | 
                     Select-Object -First 1 -ExpandProperty IPAddress
    }
    
    Write-Host "Mobile Access URL:" -ForegroundColor Cyan
    Write-Host ""
    if ($ipAddress) {
        Write-Host "  http://$ipAddress:8096/tag_filter_pwa.html" -ForegroundColor White -BackgroundColor DarkGreen
    } else {
        Write-Host "  http://YOUR_IP:8096/tag_filter_pwa.html" -ForegroundColor White
    }
    Write-Host ""
    Write-Host "Desktop Access URL:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  http://localhost:8096/tag_filter_pwa.html" -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host ""
    
    Write-Host "Next Steps:" -ForegroundColor Cyan
    Write-Host "  1. Open URL in mobile browser" -ForegroundColor White
    Write-Host "  2. Configure API key (first time only)" -ForegroundColor White
    Write-Host "  3. Add to home screen" -ForegroundColor White
    Write-Host "  4. Use like native app!" -ForegroundColor White
    Write-Host ""
    
    # Open in browser?
    Write-Host "Open in browser now? (Y/N): " -ForegroundColor Yellow -NoNewline
    $response = Read-Host
    
    if ($response -eq 'Y' -or $response -eq 'y') {
        Start-Process "http://localhost:8096/tag_filter_pwa.html"
        Write-Host ""
        Write-Host "[OK] Opened in browser" -ForegroundColor Green
    }
    
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  Deploy Incomplete" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Success: $successCount / $($files.Count)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "See docs/MOBILE_GUIDE.md for detailed instructions" -ForegroundColor Gray
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

