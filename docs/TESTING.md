# Testing Guide - 测试指南

## Quick Test - 快速测试

### 1. Deploy - 部署

```powershell
cd "C:\Users\Administrator\Documents\Personal_Materials\Scripts\JellyfinTagFilter"
.\deploy.ps1
```

### 2. Access - 访问

- **Desktop:** `http://localhost:8096/tag_filter_pwa.html`
- **Mobile:** `http://SERVER_IP:8096/tag_filter_pwa.html`

### 3. Test Features - 测试功能

- [ ] Load media library
- [ ] Select multiple tags
- [ ] Verify AND logic filtering
- [ ] Play video in-page
- [ ] Test screen rotation
- [ ] Return to filter

## Mobile Testing - 手机端测试

### iOS Checklist
- [ ] Safari browser access
- [ ] Responsive layout
- [ ] Touch controls
- [ ] Grid/List view
- [ ] Video playback
- [ ] Screen rotation
- [ ] Add to home screen

### Android Checklist
- [ ] Chrome browser access
- [ ] Responsive layout
- [ ] Touch controls
- [ ] Grid/List view
- [ ] Video playback
- [ ] Screen rotation
- [ ] Add to home screen

## Feature Testing - 功能测试

### AND Logic Test (Core Feature)

1. Select tag A (e.g., "Action")
2. Observe result count
3. Add tag B (e.g., "Sci-Fi")
4. Verify results show ONLY items with BOTH tags
5. Add more tags, verify results narrow down

### Screen Rotation Test

1. Open video player
2. Click rotation button 🔄
3. Verify cycles through: 🔄 → ↔️ → ↕️
4. Enter fullscreen
5. Verify orientation locks correctly
6. Exit fullscreen
7. Verify orientation unlocks

### In-Page Navigation Test

1. Filter and select item
2. Verify player slides in from right
3. Play video
4. Click ← back button
5. Verify returns to filter (without losing state)

## Performance Testing - 性能测试

- < 100 items: Instant
- 100-1000 items: 2-3 seconds
- 1000-5000 items: 5-10 seconds
- \> 5000 items: May need optimization

## Browser Compatibility - 浏览器兼容性

### Desktop
- [ ] Chrome / Edge
- [ ] Firefox
- [ ] Safari (macOS)

### Mobile
- [ ] Safari (iOS)
- [ ] Chrome (Android)

## Troubleshooting - 常见问题

### Cannot Load Library

1. Check server is running
2. Verify API key
3. Check Library ID
4. Open browser console (F12) for errors

### Mobile Cannot Access

1. Same network?
2. Firewall open on port 8096?
3. Using LAN IP (not localhost)?

### Video Not Playing

- Click "Open in Jellyfin" button
- Use Jellyfin's native player

---

**Test Duration:** 15-30 minutes
**Recommended:** Desktop basic test → Mobile test → Feature scenarios

