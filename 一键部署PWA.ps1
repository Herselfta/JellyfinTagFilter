# Jellyfin 标签筛选器 PWA - 一键部署脚本

param(
    [string]$JellyfinPath = "D:\JellyfinServer\wwwroot"
)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Jellyfin 标签筛选器 PWA - 部署工具" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 检查源文件
$files = @(
    @{Name="PWA 页面"; Source="jellyfin_tag_filter_pwa.html"; Target="tag_filter_pwa.html"},
    @{Name="Manifest"; Source="tag_filter_manifest.json"; Target="tag_filter_manifest.json"}
)

$allFilesExist = $true
foreach ($file in $files) {
    $sourcePath = Join-Path $ScriptDir $file.Source
    if (-not (Test-Path $sourcePath)) {
        Write-Host "❌ 错误: 找不到 $($file.Name): $sourcePath" -ForegroundColor Red
        $allFilesExist = $false
    }
}

if (-not $allFilesExist) {
    exit 1
}

# 检查目标目录
if (-not (Test-Path $JellyfinPath)) {
    Write-Host "❌ 错误: Jellyfin 目录不存在: $JellyfinPath" -ForegroundColor Red
    Write-Host "请修改脚本中的路径或使用参数指定: " -ForegroundColor Yellow
    Write-Host ".\一键部署PWA.ps1 -JellyfinPath '你的路径'" -ForegroundColor Yellow
    exit 1
}

# 检查权限
try {
    $testFile = Join-Path $JellyfinPath "test_permission.tmp"
    New-Item -ItemType File -Path $testFile -Force | Out-Null
    Remove-Item $testFile -Force
} catch {
    Write-Host "❌ 错误: 没有写入权限" -ForegroundColor Red
    Write-Host "请以管理员身份运行此脚本" -ForegroundColor Yellow
    exit 1
}

# 开始部署
Write-Host "📦 开始部署..." -ForegroundColor Yellow
Write-Host ""

$successCount = 0
foreach ($file in $files) {
    $sourcePath = Join-Path $ScriptDir $file.Source
    $targetPath = Join-Path $JellyfinPath $file.Target
    
    try {
        Copy-Item -Path $sourcePath -Destination $targetPath -Force
        Write-Host "  ✅ $($file.Name) 部署成功" -ForegroundColor Green
        $successCount++
    } catch {
        Write-Host "  ❌ $($file.Name) 部署失败: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""

if ($successCount -eq $files.Count) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  ✅ 部署完成！" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    
    # 获取本机 IP
    $ipAddress = Get-NetIPAddress -AddressFamily IPv4 | 
                  Where-Object { $_.InterfaceAlias -notlike "*Loopback*" -and $_.IPAddress -like "192.168.*" } | 
                  Select-Object -First 1 -ExpandProperty IPAddress
    
    if (-not $ipAddress) {
        $ipAddress = Get-NetIPAddress -AddressFamily IPv4 | 
                     Where-Object { $_.InterfaceAlias -notlike "*Loopback*" } | 
                     Select-Object -First 1 -ExpandProperty IPAddress
    }
    
    Write-Host "📱 手机访问地址：" -ForegroundColor Cyan
    Write-Host ""
    if ($ipAddress) {
        Write-Host "  http://$ipAddress:8096/tag_filter_pwa.html" -ForegroundColor White -BackgroundColor DarkGreen
    } else {
        Write-Host "  http://你的IP:8096/tag_filter_pwa.html" -ForegroundColor White
        Write-Host "  (无法自动检测IP，请手动查看)" -ForegroundColor Yellow
    }
    Write-Host ""
    Write-Host "💻 电脑访问地址：" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  http://localhost:8096/tag_filter_pwa.html" -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host ""
    
    Write-Host "📝 后续步骤：" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  1. 手机浏览器访问上述地址" -ForegroundColor White
    Write-Host "  2. 首次使用需配置 API 密钥" -ForegroundColor White
    Write-Host "  3. iOS Safari: 分享 → 添加到主屏幕" -ForegroundColor White
    Write-Host "  4. Android Chrome: 菜单 → 添加到主屏幕" -ForegroundColor White
    Write-Host "  5. 像 APP 一样使用！" -ForegroundColor White
    Write-Host ""
    
    Write-Host "📖 详细说明：" -ForegroundColor Cyan
    Write-Host "  查看 '使用指南_手机APP体验.md'" -ForegroundColor White
    Write-Host ""
    
    # 询问是否在浏览器中打开
    Write-Host "是否在浏览器中打开测试？(Y/N): " -ForegroundColor Yellow -NoNewline
    $response = Read-Host
    
    if ($response -eq 'Y' -or $response -eq 'y') {
        Start-Process "http://localhost:8096/tag_filter_pwa.html"
        Write-Host ""
        Write-Host "✅ 已在浏览器中打开" -ForegroundColor Green
    }
    
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  ⚠️  部署未完全成功" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "成功: $successCount / $($files.Count)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

