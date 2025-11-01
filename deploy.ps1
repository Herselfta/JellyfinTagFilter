# Jellyfin Tag Filter - Auto Deploy Script
# Deploys files to Jellyfin server wwwroot directory
# Version: 2.0 - Smart deployment with file change detection

param(
    [string]$JellyfinPath = "D:\JellyfinServer\jellyfin-web",
    [switch]$Force  # 强制部署，忽略文件检查
)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Jellyfin Tag Filter - Deploy Tool" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$VersionFile = Join-Path $ScriptDir ".deploy_version"

# Files to deploy
$files = @(
    @{Name="PWA HTML"; Source="jellyfin_tag_filter_pwa.html"; Target="tag_filter_pwa.html"},
    @{Name="Manifest"; Source="tag_filter_manifest.json"; Target="tag_filter_manifest.json"}
)

# 计算文件哈希
function Get-FileHashValue {
    param([string]$FilePath)
    if (Test-Path $FilePath) {
        return (Get-FileHash -Path $FilePath -Algorithm MD5).Hash
    }
    return $null
}

# 检查是否需要部署
function Test-NeedDeploy {
    if ($Force) {
        Write-Host "强制部署模式" -ForegroundColor Yellow
        return $true
    }
    
    # 读取上次部署的哈希值
    $lastHashes = @{}
    if (Test-Path $VersionFile) {
        Get-Content $VersionFile | ForEach-Object {
            $parts = $_ -split '='
            if ($parts.Length -eq 2) {
                $lastHashes[$parts[0]] = $parts[1]
            }
        }
    }
    
    # 检查文件是否有变化
    $needDeploy = $false
    foreach ($file in $files) {
        $sourcePath = Join-Path $ScriptDir $file.Source
        $currentHash = Get-FileHashValue $sourcePath
        $lastHash = $lastHashes[$file.Source]
        
        if ($currentHash -ne $lastHash) {
            $needDeploy = $true
            Write-Host "  检测到变化: $($file.Name)" -ForegroundColor Yellow
        }
    }
    
    if (-not $needDeploy) {
        Write-Host "✅ 文件未变化，无需重新部署" -ForegroundColor Green
        Write-Host ""
        
        # 验证现有部署是否可访问
        Write-Host "🔍 验证现有部署..." -ForegroundColor Cyan
        $testUrl = "http://localhost:8096/web/tag_filter_pwa.html"
        try {
            $testResponse = Invoke-WebRequest -Uri $testUrl -Method Head -TimeoutSec 5 -UseBasicParsing -ErrorAction Stop
            Write-Host "  ✅ 访问正常 (状态码: $($testResponse.StatusCode))" -ForegroundColor Green
        } catch {
            Write-Host "  ❌ 访问失败，建议使用 -Force 重新部署" -ForegroundColor Red
        }
        
        Write-Host ""
        Write-Host "提示：" -ForegroundColor Cyan
        Write-Host "  • 如需强制部署，使用: .\deploy.ps1 -Force" -ForegroundColor Gray
        Write-Host "  • 直接访问: http://localhost:8096/web/tag_filter_pwa.html" -ForegroundColor Gray
        return $false
    }
    
    return $true
}

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

# 检查是否需要部署
if (-not (Test-NeedDeploy)) {
    Write-Host ""
    Write-Host "按任意键退出..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 0
}

# Deploy files
Write-Host ""
Write-Host "开始部署..." -ForegroundColor Yellow
Write-Host ""

$successCount = 0
$newHashes = @{}

foreach ($file in $files) {
    $sourcePath = Join-Path $ScriptDir $file.Source
    $targetPath = Join-Path $JellyfinPath $file.Target
    
    try {
        Copy-Item -Path $sourcePath -Destination $targetPath -Force
        Write-Host "  [OK] $($file.Name)" -ForegroundColor Green
        
        # 记录新的哈希值
        $hash = Get-FileHashValue $sourcePath
        $newHashes[$file.Source] = $hash
        
        $successCount++
    } catch {
        Write-Host "  [FAIL] $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 保存部署版本信息
if ($successCount -eq $files.Count) {
    $hashContent = ($newHashes.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join "`n"
    Set-Content -Path $VersionFile -Value $hashContent
}

Write-Host ""

if ($successCount -eq $files.Count) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  部署成功！" -ForegroundColor Green
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
    
    # 验证部署是否成功
    Write-Host "� 验证部署..." -ForegroundColor Cyan
    Start-Sleep -Milliseconds 500
    
    $testUrl = "http://localhost:8096/web/tag_filter_pwa.html"
    try {
        $testResponse = Invoke-WebRequest -Uri $testUrl -Method Head -TimeoutSec 5 -UseBasicParsing -ErrorAction Stop
        Write-Host "  ✅ 访问验证成功 (状态码: $($testResponse.StatusCode))" -ForegroundColor Green
        $deploySuccess = $true
    } catch {
        Write-Host "  ❌ 访问验证失败: $($_.Exception.Message)" -ForegroundColor Red
        if ($_.Exception.Response) {
            Write-Host "  状态码: $($_.Exception.Response.StatusCode.value__)" -ForegroundColor Yellow
        }
        $deploySuccess = $false
    }
    
    Write-Host ""
    
    if ($deploySuccess) {
        Write-Host "�📱 移动端访问：" -ForegroundColor Cyan
        Write-Host ""
        if ($ipAddress) {
            Write-Host "  http://$ipAddress:8096/web/tag_filter_pwa.html" -ForegroundColor White -BackgroundColor DarkGreen
        } else {
            Write-Host "  http://YOUR_IP:8096/web/tag_filter_pwa.html" -ForegroundColor White
        }
        Write-Host ""
        Write-Host "💻 桌面端访问：" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  http://localhost:8096/web/tag_filter_pwa.html" -ForegroundColor White -BackgroundColor DarkBlue
        Write-Host ""
        
        Write-Host "💡 一次配置，永久使用：" -ForegroundColor Cyan
        Write-Host "  1. 首次访问 → 配置服务器信息" -ForegroundColor White
        Write-Host "  2. 点击 [📋 分享链接] → 保存到浏览器书签" -ForegroundColor White
        Write-Host "  3. 添加到主屏幕 → 像原生应用一样使用" -ForegroundColor White
        Write-Host "  4. 以后直接从主屏幕打开，无需重新部署！" -ForegroundColor Green
        Write-Host ""
        
        Write-Host "🔄 下次部署：" -ForegroundColor Cyan
        Write-Host "  • 文件未变化时会自动跳过部署" -ForegroundColor Gray
        Write-Host "  • 强制部署: .\deploy.ps1 -Force" -ForegroundColor Gray
        Write-Host ""
        
        # 验证部署
        Write-Host "🔍 验证部署..." -ForegroundColor Cyan
        Write-Host ""
        
        $testUrl = "http://localhost:8096/web/tag_filter_pwa.html"
        $testPassed = $false
        
        try {
            $response = Invoke-WebRequest -Uri $testUrl -Method Head -TimeoutSec 5 -ErrorAction Stop
            if ($response.StatusCode -eq 200) {
                Write-Host "  ✅ 文件可以正常访问" -ForegroundColor Green
                $testPassed = $true
            }
        } catch {
            $statusCode = if ($_.Exception.Response) { $_.Exception.Response.StatusCode.value__ } else { "未知" }
            Write-Host "  ❌ 无法访问页面 (HTTP $statusCode)" -ForegroundColor Red
            Write-Host ""
            Write-Host "可能的原因：" -ForegroundColor Yellow
            Write-Host "  1. Jellyfin 服务未运行" -ForegroundColor White
            Write-Host "  2. 部署路径不正确（当前: $JellyfinPath）" -ForegroundColor White
            Write-Host "  3. Jellyfin 静态文件配置问题" -ForegroundColor White
        }
        
        Write-Host ""
        
        if ($testPassed) {
            # Open in browser?
            Write-Host "✅ 部署验证成功！是否在浏览器中打开测试? (Y/N): " -ForegroundColor Green -NoNewline
            $openBrowser = Read-Host
            
            if ($openBrowser -eq 'Y' -or $openBrowser -eq 'y') {
                Start-Process $testUrl
                Write-Host ""
                Write-Host "[OK] 已在浏览器中打开" -ForegroundColor Green
                Write-Host ""
                
                # 等待用户确认
                Start-Sleep -Seconds 2
                Write-Host "页面是否正常显示? (Y/N): " -ForegroundColor Yellow -NoNewline
                $pageWorks = Read-Host
                
                if ($pageWorks -eq 'Y' -or $pageWorks -eq 'y') {
                    Write-Host ""
                    Write-Host "🎉 部署完全成功！" -ForegroundColor Green
                } else {
                    Write-Host ""
                    Write-Host "⚠️  页面显示异常，请按 F12 查看浏览器控制台错误" -ForegroundColor Yellow
                    Write-Host "常见问题：" -ForegroundColor Yellow
                    Write-Host "  • 检查 Jellyfin 服务器地址配置" -ForegroundColor White
                    Write-Host "  • 检查 API Key 是否正确" -ForegroundColor White
                    Write-Host "  • 查看浏览器控制台的具体错误信息" -ForegroundColor White
                }
            }
        } else {
            Write-Host "❌ 部署验证失败" -ForegroundColor Red
            Write-Host ""
            Write-Host "请尝试：" -ForegroundColor Yellow
            Write-Host "  1. 检查 Jellyfin 服务: Get-Process jellyfin" -ForegroundColor White
            Write-Host "  2. 检查部署路径: Test-Path '$JellyfinPath'" -ForegroundColor White
            Write-Host "  3. 手动访问: $testUrl" -ForegroundColor White
        }
    } else {
        Write-Host "⚠️  部署可能存在问题，请检查：" -ForegroundColor Yellow
        Write-Host "  1. Jellyfin 服务是否正在运行" -ForegroundColor White
        Write-Host "  2. 部署路径是否正确: $JellyfinPath" -ForegroundColor White
        Write-Host "  3. 文件权限是否正确" -ForegroundColor White
    }
    
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  部署未完成" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "成功: $successCount / $($files.Count)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "See docs/MOBILE_GUIDE.md for detailed instructions" -ForegroundColor Gray
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

