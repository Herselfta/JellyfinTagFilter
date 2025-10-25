# API Setup Guide - API 配置指南

## Get Jellyfin API Key - 获取 API 密钥

### Step 1: Login to Jellyfin
1. Open Jellyfin web interface
2. Login as administrator

### Step 2: Navigate to API Keys
1. Dashboard → Settings
2. Advanced → API Keys

### Step 3: Create New Key
1. Click "+" or "Add API Key"
2. Enter app name: `Tag Filter` or `标签筛选器`
3. Click OK
4. **Copy the generated key** (you won't see it again)

## Get Library ID - 获取媒体库 ID

### Method 1: From URL (Easiest)

1. Open your library in Jellyfin web
2. Look at browser URL:
   ```
   http://localhost:8096/web/index.html#!/movies.html?topParentId=abc123def456
                                                                   ^^^^^^^^^^^^^^
                                                                   Library ID
   ```
3. Copy the ID after `topParentId=`

### Method 2: From API

1. Open in browser (replace YOUR_KEY):
   ```
   http://localhost:8096/Library/VirtualFolders?api_key=YOUR_KEY
   ```

2. Find your library in the JSON response
3. Copy the `ItemId` field

Example response:
```json
{
  "Name": "Movies",
  "ItemId": "abc123def456",
  "Locations": [...]
}
```

## Server URL - 服务器地址

### Local Access
```
http://localhost:8096
```

### LAN Access (Mobile)
```
http://192.168.x.x:8096
```

To find your server IP:
```powershell
ipconfig
# Look for IPv4 Address (e.g., 192.168.1.100)
```

### Remote Access
```
https://your-domain.com
```

## Troubleshooting - 故障排除

### API Key Invalid

**Error:** HTTP 401 or 403

**Solution:**
1. Regenerate API key in Jellyfin
2. Make sure you copied the full key
3. No spaces before/after the key

### Library ID Wrong

**Error:** No items loaded or wrong items

**Solution:**
1. Double-check the Library ID
2. Make sure you're using the correct library
3. Try the API method to verify

### Cannot Connect

**Error:** Network error or timeout

**Solution:**
1. Check Jellyfin server is running
2. Verify server URL is correct
3. Check firewall allows port 8096
4. For mobile: ensure on same network

## Security Notes - 安全说明

- API key is stored in browser localStorage
- Never shared with third parties
- Only communicates with your Jellyfin server
- Don't save on public/shared devices

---

**Next:** See [MOBILE_GUIDE.md](MOBILE_GUIDE.md) for mobile usage

