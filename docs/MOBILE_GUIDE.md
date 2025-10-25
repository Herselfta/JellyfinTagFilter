# 📱 Mobile Guide - 手机端使用指南

## Quick Start - 快速开始

### Deploy to Server - 部署到服务器

```powershell
cd "C:\Users\Administrator\Documents\Personal_Materials\Scripts\JellyfinTagFilter"
.\deploy.ps1
```

### Access from Mobile - 手机访问

```
http://YOUR_SERVER_IP:8096/tag_filter_pwa.html
```

### Add to Home Screen - 添加到主屏幕

**iOS (Safari):**
1. Open in Safari
2. Tap Share button
3. Add to Home Screen

**Android (Chrome):**
1. Open in Chrome  
2. Menu → Add to Home Screen

## Features - 功能特点

- ✅ **AND Logic Filtering** - AND 逻辑标签筛选
- ✅ **In-Page Playback** - 同页面播放
- ✅ **Screen Rotation Control** - 屏幕方向控制
- ✅ **Jellyfin Theme** - Jellyfin 原生主题
- ✅ **PWA Support** - 可添加到主屏幕

## Controls - 操作说明

### Filter Tags - 筛选标签
- Tap tags to select (multiple selection)
- Results show items with ALL selected tags

### Screen Rotation - 屏幕旋转
- 🔄 Auto mode - 自动模式
- ↔️ Landscape mode - 横屏模式  
- ↕️ Portrait mode - 竖屏模式

Tap the rotation button (top right) to cycle through modes.

### Usage Flow - 使用流程

```
1. Select tags → Filter content
2. Tap item → Open in player
3. Tap play → Watch video
4. Tap ← → Return to filter
```

## Configuration - 配置

First time setup:
1. Tap ⚙️ (settings icon)
2. Enter server URL, API key, Library ID
3. Tap "Load Library"
4. Configuration auto-saves

## Troubleshooting - 故障排除

### Cannot Access from Mobile

- Ensure phone and server on same network
- Check firewall allows port 8096
- Use server's LAN IP (not localhost)

### Screen Rotation Not Working

- Feature requires fullscreen mode
- Some browsers may not support
- Use manual rotation button

---

For detailed documentation, see [USAGE.md](USAGE.md)

