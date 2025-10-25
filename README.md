# Jellyfin Tag Filter (AND Logic)

> A custom tag filtering tool for Jellyfin with AND logic support

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Jellyfin](https://img.shields.io/badge/Jellyfin-10.8+-purple.svg)](https://jellyfin.org)
[![PWA](https://img.shields.io/badge/PWA-Enabled-green.svg)](tag_filter_manifest.json)

**[Quick Start](QUICKSTART.md)** | [中文文档](docs/USAGE.md) | [Mobile Guide](docs/MOBILE_GUIDE.md) | [API Setup](docs/API_SETUP.md)

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

### 1. Deploy to Jellyfin Server

```powershell
cd "C:\Users\Administrator\Documents\Personal_Materials\Scripts\JellyfinTagFilter"
.\deploy.ps1
```

### 2. Access

- **Desktop:** `http://localhost:8096/tag_filter_pwa.html`
- **Mobile:** `http://YOUR_SERVER_IP:8096/tag_filter_pwa.html`

### 3. Configure (First Time)

1. Click ⚙️ settings icon
2. Enter:
   - Server URL: `http://YOUR_SERVER_IP:8096`
   - API Key: Get from Jellyfin Dashboard → API Keys
   - Library ID: Get from library URL or API
3. Click "Load Library"

### 4. Use

1. Select tags (click to toggle)
2. View filtered results (AND logic)
3. Click item to play
4. Click ← to return

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
├── deploy.ps1                       # Auto-deploy script
├── README.md                        # This file
├── LICENSE                          # MIT License
├── CHANGELOG.md                     # Version history
├── CONTRIBUTING.md                  # Contribution guide
├── .gitignore                       # Git ignore rules
└── docs/                            # Documentation
    ├── USAGE.md                     # Detailed usage (Chinese)
    ├── MOBILE_GUIDE.md              # Mobile guide
    └── TESTING.md                   # Testing guide
```

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

See [CONTRIBUTING.md](CONTRIBUTING.md)

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md)

## 📄 License

[MIT License](LICENSE)

## ⚠️ Disclaimer

This is a personal tool. Use at your own risk.

---

**Get Started:** Run `.\deploy.ps1` and access from mobile browser!
