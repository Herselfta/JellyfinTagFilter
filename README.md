# Jellyfin 标签筛选器 (AND 逻辑)

> 一个独立的 Jellyfin 标签筛选工具，支持 AND 逻辑的多标签筛选

## 🎯 功能特点

- ✅ **AND 逻辑筛选**：同时选择多个标签，只显示包含所有选中标签的媒体
- ✅ **PWA 支持**：添加到手机主屏幕，像原生 APP 一样使用
- ✅ **响应式设计**：完美适配手机、平板、电脑
- ✅ **Jellyfin 风格**：界面风格与 Jellyfin 一致
- ✅ **快速部署**：一键部署脚本，3 分钟完成
- ✅ **无需安装**：纯 Web 应用，无需编译或安装
- ✅ **跨平台**：支持 iOS、Android、Windows、macOS、Linux

## 🆚 与 Jellyfin 原生筛选的区别

| 特性 | Jellyfin 原生 | 本工具 |
|------|--------------|--------|
| 筛选逻辑 | **OR**（任一标签匹配） | **AND**（全部标签匹配） |
| 使用场景 | 想看"动作"或"科幻"的电影 | 想看"动作"且"科幻"的电影 |
| 手机端 | APP 和 Web | Web + PWA（可添加到主屏幕） |

### 示例说明

假设你有以下电影：
- 电影 A：`[动作, 科幻, 2020s]`
- 电影 B：`[动作, 喜剧, 2010s]`
- 电影 C：`[科幻, 惊悚, 2020s]`

**选择标签：动作 + 科幻**

- Jellyfin 原生（OR）：显示 A、B、C（包含任一标签）
- 本工具（AND）：**只显示 A**（同时包含两个标签）

## 📦 文件说明

- `jellyfin_tag_filter.html` - 基础版筛选器（独立 HTML 文件）
- `jellyfin_tag_filter_pwa.html` - **PWA 版筛选器**（Jellyfin 风格，推荐）
- `tag_filter_manifest.json` - PWA 配置文件
- `一键部署PWA.ps1` - **自动部署脚本**（推荐使用）
- `TAG_FILTER_README.md` - 基础版详细说明
- `使用指南_手机APP体验.md` - 手机端 PWA 使用完整指南
- `快速测试指南.md` - 测试和验收指南
- `一键部署说明.txt` - 快速部署步骤（文本版）

## 🚀 快速开始

### 方式 1：一键部署（推荐）⭐

```powershell
cd "C:\Users\Administrator\Documents\Personal_Materials\Scripts\JellyfinTagFilter"
.\一键部署PWA.ps1
```

**脚本会自动：**
1. ✅ 复制文件到 Jellyfin 服务器
2. ✅ 检测并显示访问地址
3. ✅ 提供详细的后续步骤指引
4. ✅ 可选在浏览器中打开测试

### 方式 2：手动部署

```powershell
# 复制 PWA 版本到 Jellyfin 服务器
Copy-Item "jellyfin_tag_filter_pwa.html" "D:\JellyfinServer\wwwroot\tag_filter_pwa.html"
Copy-Item "tag_filter_manifest.json" "D:\JellyfinServer\wwwroot\tag_filter_manifest.json"
```

### 方式 3：直接使用（测试用）

双击 `jellyfin_tag_filter_pwa.html` 在浏览器中打开（可能有跨域限制）。

## 📱 手机端使用

### 浏览器访问

```
http://你的服务器IP:8096/tag_filter_pwa.html
```

例如：`http://192.168.1.100:8096/tag_filter_pwa.html`

### 添加到主屏幕（像 APP 一样）

**iOS (Safari):**
1. 打开筛选器页面
2. 点击 **分享** → **添加到主屏幕**
3. 确认添加

**Android (Chrome):**
1. 打开筛选器页面
2. 菜单 → **添加到主屏幕** 或 **安装应用**
3. 确认添加

### PWA 体验特点

- ✅ 全屏运行（无浏览器地址栏）
- ✅ 独立应用图标
- ✅ 与原生 APP 体验接近
- ✅ 自动保存配置

## 🔑 首次配置

### 需要的信息

1. **Jellyfin 服务器地址**
   - 本机：`http://localhost:8096`
   - 局域网：`http://192.168.x.x:8096`

2. **API 密钥**
   - Jellyfin 后台 → 设置 → API 密钥 → 添加新密钥

3. **媒体库 ID**
   - 打开 Jellyfin 媒体库，从 URL 中获取 `topParentId` 参数
   - 或访问 `http://localhost:8096/Library/VirtualFolders?api_key=你的密钥`

详细步骤请查看 `TAG_FILTER_README.md`

## 💡 使用流程

1. **首次访问**：填写配置信息（会自动保存）
2. **加载媒体库**：点击"加载媒体库"按钮
3. **选择标签**：点击多个标签（蓝色 = 已选）
4. **查看结果**：只显示同时包含所有标签的媒体
5. **播放媒体**：点击媒体项，跳转到 Jellyfin 播放

## 🎨 界面版本对比

### 基础版 (jellyfin_tag_filter.html)

- 🎨 紫色渐变背景
- 📱 响应式设计
- ✅ 完整功能
- 💾 配置自动保存

### PWA 版 (jellyfin_tag_filter_pwa.html) ⭐推荐

- 🖤 Jellyfin 黑色主题
- 📱 手机优化（大按钮、触摸友好）
- 🔧 可折叠配置面板
- 💫 流畅动画效果
- 📲 PWA 支持（添加到主屏幕）

## 🛠️ 技术栈

- **前端**：纯 HTML + CSS + JavaScript
- **API**：Jellyfin REST API
- **存储**：浏览器 LocalStorage
- **兼容性**：所有现代浏览器

## 📖 详细文档

- **基础使用**：`TAG_FILTER_README.md`
- **手机 APP 体验**：`使用指南_手机APP体验.md`
- **测试指南**：`快速测试指南.md`

## 🔗 相关项目

- **Eagle 到 Jellyfin 标签同步工具**：`../EagleTagToJellyfin`
  - 用于将 Eagle 图库的标签同步到 Jellyfin NFO
  - 与本筛选器完美配合使用

## 💬 使用建议

### 推荐工作流

```
1. 使用 Eagle 管理媒体，打标签
2. 运行同步工具，将标签同步到 Jellyfin
3. 使用本筛选器，通过 AND 逻辑精确查找
4. 点击跳转到 Jellyfin 播放
```

### 典型场景

- **精确查找**：想看"动作 + 科幻 + 2020s + 高分"的电影
- **标签组合**：同时筛选多个维度（类型 + 年代 + 主题）
- **快速浏览**：通过标签快速定位想看的内容

## 🔧 故障排除

### 无法加载媒体库

- 检查 Jellyfin 服务器是否运行
- 检查 API 密钥是否正确
- 检查媒体库 ID 是否正确

### 手机无法访问

- 确保手机和服务器在同一网络
- 检查防火墙是否阻止 8096 端口
- 使用服务器的局域网 IP（不是 localhost）

### 配置丢失

- 配置保存在浏览器 LocalStorage
- 清除浏览器数据会导致配置丢失
- 重新填写配置即可（很快）

详细故障排除请查看对应文档。

## 📊 性能说明

- **小型媒体库**（< 1000 项）：秒开
- **中型媒体库**（1000-5000 项）：5-10 秒
- **大型媒体库**（> 5000 项）：可能需要优化（分页或虚拟滚动）

筛选操作本身是即时的，只有首次加载需要等待。

## 🎓 进阶使用

### 结合 Eagle 标签系统

1. 在 Eagle 中建立标签体系（类型、年代、主题等）
2. 为媒体打标签
3. 同步到 Jellyfin
4. 使用本工具进行复杂筛选

### 自定义样式

如需修改界面样式，可以编辑 HTML 文件中的 `<style>` 部分。

## 📝 更新日志

### v1.0 (2025-10-25)
- ✨ 首次发布
- ✅ 基础版和 PWA 版
- ✅ AND 逻辑筛选
- ✅ 响应式设计
- ✅ 一键部署脚本
- ✅ 完整文档

## 📄 许可证

仅供个人使用

## 🙏 致谢

- Jellyfin 项目提供了强大的媒体服务器
- 本工具基于 Jellyfin API 开发

---

**开始使用：** 运行 `.\一键部署PWA.ps1` 或查看 `使用指南_手机APP体验.md`

