# Jellyfin Tag Filter - 快捷链接生成器
# 生成带配置的访问链接，保存后无需重复配置

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  快捷链接生成器" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 读取配置
$server = Read-Host "服务器地址 (例如: http://192.168.1.100:8096)"
$apiKey = Read-Host "API 密钥"
$libraryId = Read-Host "媒体库 ID"

if (-not $server -or -not $apiKey -or -not $libraryId) {
    Write-Host ""
    Write-Host "❌ 配置不完整" -ForegroundColor Red
    Write-Host "按任意键退出..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  生成成功！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# 获取IP地址
$ipAddress = Get-NetIPAddress -AddressFamily IPv4 | 
              Where-Object { $_.InterfaceAlias -notlike "*Loopback*" -and $_.IPAddress -like "192.168.*" } | 
              Select-Object -First 1 -ExpandProperty IPAddress

if (-not $ipAddress) {
    $ipAddress = Get-NetIPAddress -AddressFamily IPv4 | 
                 Where-Object { $_.InterfaceAlias -notlike "*Loopback*" } | 
                 Select-Object -First 1 -ExpandProperty IPAddress
}

# 生成链接
$baseUrl = if ($ipAddress) {
    "http://${ipAddress}:8096/web/tag_filter_pwa.html"
} else {
    "http://YOUR_IP:8096/web/tag_filter_pwa.html"
}

$configUrl = "${baseUrl}?server=$([uri]::EscapeDataString($server))&key=$([uri]::EscapeDataString($apiKey))&library=$([uri]::EscapeDataString($libraryId))"

Write-Host "📋 您的专属访问链接：" -ForegroundColor Cyan
Write-Host ""
Write-Host $configUrl -ForegroundColor White -BackgroundColor DarkGreen
Write-Host ""

Write-Host "💾 保存建议：" -ForegroundColor Yellow
Write-Host "  1. 浏览器书签 - 电脑端使用" -ForegroundColor White
Write-Host "  2. 备忘录/笔记 - 手机端访问" -ForegroundColor White
Write-Host "  3. 发送到其他设备 - 多设备同步" -ForegroundColor White
Write-Host ""

Write-Host "✨ 使用方法：" -ForegroundColor Cyan
Write-Host "  • 直接打开链接 → 自动配置完成" -ForegroundColor White
Write-Host "  • 添加到主屏幕 → 像原生应用" -ForegroundColor White
Write-Host "  • 无需重复配置 → 一劳永逸" -ForegroundColor Green
Write-Host ""

# 复制到剪贴板
try {
    Set-Clipboard -Value $configUrl
    Write-Host "✅ 链接已复制到剪贴板！" -ForegroundColor Green
} catch {
    Write-Host "⚠️  请手动复制上方链接" -ForegroundColor Yellow
}

Write-Host ""

# 是否保存到文件
Write-Host "是否保存到文件? (Y/N): " -ForegroundColor Yellow -NoNewline
$response = Read-Host

if ($response -eq 'Y' -or $response -eq 'y') {
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $filename = "jellyfin_shortcut_${timestamp}.txt"
    
    $content = @"
Jellyfin Tag Filter - 快捷访问链接
生成时间: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

访问链接:
$configUrl

使用说明:
1. 直接在浏览器中打开上方链接
2. 页面会自动完成配置
3. 建议添加到浏览器书签或手机主屏幕
4. 以后直接使用，无需重新配置

配置信息:
服务器: $server
媒体库 ID: $libraryId

注意: 请妥善保管此文件，其中包含 API 密钥
"@
    
    Set-Content -Path $filename -Value $content -Encoding UTF8
    Write-Host ""
    Write-Host "✅ 已保存到: $filename" -ForegroundColor Green
}

Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
