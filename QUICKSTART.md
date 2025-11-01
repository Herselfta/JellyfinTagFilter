# Quick Start - 快速开始

## ⚡ One-Time Setup (一次性设置)

### 1️⃣ Deploy - 部署 (只需一次)

```powershell
cd "C:\Users\Administrator\Documents\Personal_Materials\Scripts\JellyfinTagFilter"
.\deploy.ps1
```

> 💡 文件未变化时会自动跳过，无需重复部署

### 2️⃣ Access - 访问

**Mobile:** `http://YOUR_SERVER_IP:8096/web/tag_filter_pwa.html`

**Desktop:** `http://localhost:8096/web/tag_filter_pwa.html`

### 3️⃣ Configure - 配置 (首次访问)

1. Click ⚙️ (settings)
2. Enter:
   - Server URL
   - API Key ([How to get?](docs/API_SETUP.md))
   - Library ID ([How to get?](docs/API_SETUP.md))
3. Click "Load Library"

### 4️⃣ Make it Persistent - 持久化设置 ⭐

**Choose ONE method:**

#### Option A: Quick Link (推荐)
1. Click `📋 分享链接` button
2. Save the link to bookmarks/notes
3. **Use the saved link next time - auto-configured!**

#### Option B: PWA Install (最佳体验)
- **iOS:** Share → Add to Home Screen
- **Android:** Menu → Add to Home Screen
- **Use like a native app!**

#### Option C: Config File
1. Click `💾 导出` to save config
2. Click `📂 导入` on other devices

---

## 🎉 Daily Usage (日常使用)

**No need to deploy or configure again!**

1. Open from bookmark/home screen
2. Select tags → View results
3. Click to play → ← Back

That's it!

## Usage - 使用方法

```
Select tags → View results → Click to play → ← Back
```

## Add to Home Screen - 添加到主屏幕

**iOS:** Share → Add to Home Screen

**Android:** Menu → Add to Home Screen

## 🔧 Advanced Tools

### Generate Shortcut Link
```powershell
.\create_shortcut.ps1
```
Auto-generates a configured URL for you to save and share!

## Need Help? - 需要帮助？

- [**Persistence Guide**](docs/PERSISTENCE_GUIDE.md) - **持久化完整指南** ⭐ NEW
- [Detailed Usage](docs/USAGE.md) - 详细使用说明
- [Mobile Guide](docs/MOBILE_GUIDE.md) - 手机端指南
- [API Setup](docs/API_SETUP.md) - API 配置
- [Testing](docs/TESTING.md) - 测试指南

---

**Setup Time:** < 5 minutes  
**Use Forever:** ♾️ No re-configuration needed!

