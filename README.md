# Jellyfin Tag Filter (AND Logic)

> A custom tag filtering tool for Jellyfin with AND logic support

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Jellyfin](https://img.shields.io/badge/Jellyfin-10.8+-purple.svg)](https://jellyfin.org)
[![PWA](https://img.shields.io/badge/PWA-Enabled-green.svg)](tag_filter_manifest.json)

**[Quick Start](QUICKSTART.md)** | [持久化指南](docs/PERSISTENCE_GUIDE.md) | [Mobile Guide](docs/MOBILE_GUIDE.md) | [API Setup](docs/API_SETUP.md)

## ✨ Features

- ✅ **AND Logic Filtering** - Filter by multiple tags simultaneously (shows items containing ALL selected tags)
- ✅ **PWA Support** - Add to home screen, works like native app
- ✅ **In-Page Playback** - Play videos without leaving the filter page
- ✅ **Screen Rotation Control** - Manual landscape/portrait toggle
- ✅ **Jellyfin Theme** - Native Jellyfin dark theme
- ✅ **Responsive Design** - Perfect for mobile, tablet, and desktop
- ✅ **Grid/List View** - Switch between poster grid and detailed list

## 🆚 vs Jellyfin Native Filter

| Feature | Jellyfin Native | This Tool |
|---------|----------------|-----------|
| Logic | **OR** (any tag matches) | **AND** (all tags match) |
| Use Case | Items with "Action" OR "Sci-Fi" | Items with "Action" AND "Sci-Fi" |
| Platform | Native apps | Web + PWA |

### Example

Given these movies:
- Movie A: `[Action, Sci-Fi, 2020s]`
- Movie B: `[Action, Comedy, 2010s]`
- Movie C: `[Sci-Fi, Thriller, 2020s]`

**Select tags: Action + Sci-Fi**
- Jellyfin native (OR): Shows A, B, C (any tag matches)
- This tool (AND): Shows **only A** (both tags match)

## 🚀 Quick Start

### 1. Deploy to Jellyfin Server (一次性操作)

```powershell
cd "C:\Users\Administrator\Documents\Personal_Materials\Scripts\JellyfinTagFilter"
.\deploy.ps1
```

> 💡 **智能部署**: 文件未变化时自动跳过，无需重复部署！

### 2. Configure (首次配置)

1. 访问: `http://YOUR_SERVER_IP:8096/web/tag_filter_pwa.html`
2. 点击 ⚙️ 设置图标
3. 输入配置:
   - Server URL: `http://YOUR_SERVER_IP:8096`
   - API Key: Jellyfin Dashboard → API Keys
   - Library ID: 从媒体库 URL 或 API 获取
4. 点击 "加载媒体库"

### 3. 持久化设置 (选择任一方式)

**方式一：分享链接** ⭐ 推荐
1. 配置完成后点击 `📋 分享链接`
2. 链接自动复制到剪贴板
3. 保存到浏览器书签或备忘录
4. 下次直接打开链接，自动配置完成！

**方式二：配置文件**
1. 点击 `💾 导出` 保存配置文件
2. 在其他设备点击 `📂 导入` 加载配置

**方式三：添加到主屏幕** 📱 最佳体验
- iOS: Safari → 分享 → 添加到主屏幕
- Android: Chrome → 菜单 → 添加到主屏幕
- 从主屏幕打开，像原生应用一样使用！

### 4. 日常使用

1. 从书签/主屏幕直接打开 (无需重新配置)
2. 选择标签进行筛选 (AND 逻辑)
3. 点击项目播放
4. 点击 ← 返回列表

> 💡 **一次配置，永久使用** - 无需每次都重新部署或配置！

## 📱 Mobile Usage

### Add to Home Screen

**iOS (Safari):**
```
Share → Add to Home Screen
```

**Android (Chrome):**
```
Menu → Add to Home Screen
```

### Screen Rotation

Click the rotation button (top right when playing):
- 🔄 Auto mode
- ↔️ Landscape (lock horizontal)
- ↕️ Portrait (lock vertical)

## 📁 Project Structure

```
JellyfinTagFilter/
├── jellyfin_tag_filter_pwa.html    # Main application (PWA)
├── tag_filter_manifest.json        # PWA configuration
├── deploy.ps1                       # Smart deploy script
├── create_shortcut.ps1             # Shortcut generator
├── README.md                        # This file
├── QUICKSTART.md                    # Quick start guide
├── CHANGELOG.md                     # Version history
├── LICENSE                          # MIT License
└── docs/                            # Documentation
    ├── PERSISTENCE_GUIDE.md         # Persistence guide (持久化指南)
    ├── CONTRIBUTING.md              # Contribution guide
    ├── USAGE.md                     # Detailed usage (Chinese)
    ├── MOBILE_GUIDE.md              # Mobile guide
    └── TESTING.md                   # Testing guide
```

## 🔧 Advanced Tools

### 快捷链接生成器

快速生成带配置的访问链接：

```powershell
.\create_shortcut.ps1
```

输入配置信息后，生成专属链接并自动复制到剪贴板。保存此链接后可在任何设备直接使用！

## 🔑 Configuration

### Get API Key

1. Jellyfin Dashboard → Settings → Advanced → API Keys
2. Add new API key
3. Copy generated key

### Get Library ID

**Method 1:** From URL
```
http://localhost:8096/web/index.html#!/movies.html?topParentId=abc123
                                                               ^^^^^^
                                                            Library ID
```

**Method 2:** From API
```
http://localhost:8096/Library/VirtualFolders?api_key=YOUR_KEY
```

Find `ItemId` in response JSON.

## 🛠️ Tech Stack

- Pure HTML + CSS + JavaScript
- Jellyfin REST API
- Browser LocalStorage
- PWA (Progressive Web App)

## 🔗 Related Projects

- [Eagle to Jellyfin Tag Sync](https://github.com/Herselfta/EagleTagToJellyfin) - Sync tags from Eagle to Jellyfin NFO

## 📊 Requirements

- Jellyfin Server 10.8+
- Modern web browser (Chrome, Safari, Firefox, Edge)
- For mobile: iOS Safari or Android Chrome

## 🤝 Contributing

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md)

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md)

## 📄 License

[MIT License](LICENSE)

## ⚠️ Disclaimer

This is a personal tool. Use at your own risk.

---

**Get Started:** Run `.\deploy.ps1` and access from mobile browser!
