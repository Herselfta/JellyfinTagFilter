# Project Structure - 项目结构说明

## Directory Layout - 目录布局

```
JellyfinTagFilter/
│
├── jellyfin_tag_filter_pwa.html    # 主应用文件 (PWA)
├── tag_filter_manifest.json        # PWA 配置
├── deploy.ps1                       # 部署脚本
│
├── README.md                        # 项目说明（主文档）
├── LICENSE                          # MIT 许可证
├── CHANGELOG.md                     # 版本历史
├── CONTRIBUTING.md                  # 贡献指南
│
├── .gitignore                       # Git 忽略规则
├── .gitattributes                   # Git 属性配置
│
└── docs/                            # 文档目录
    ├── API_SETUP.md                 # API 配置指南
    ├── MOBILE_GUIDE.md              # 手机端使用指南
    ├── TESTING.md                   # 测试指南
    ├── USAGE.md                     # 详细使用说明（中文）
    └── PROJECT_STRUCTURE.md         # 本文件
```

## File Descriptions - 文件说明

### Core Files - 核心文件

| File | Description | Language |
|------|-------------|----------|
| `jellyfin_tag_filter_pwa.html` | 主应用（包含 HTML、CSS、JavaScript） | HTML/CSS/JS |
| `tag_filter_manifest.json` | PWA 配置（图标、主题等） | JSON |
| `deploy.ps1` | 自动部署到 Jellyfin 服务器 | PowerShell |

### Documentation - 文档

| File | Description | Language |
|------|-------------|----------|
| `README.md` | 项目概述、快速开始 | English |
| `LICENSE` | MIT 开源许可证 | English |
| `CHANGELOG.md` | 版本更新历史 | Chinese |
| `CONTRIBUTING.md` | 贡献指南 | Chinese |

### docs/ Directory - 文档目录

| File | Description | Audience |
|------|-------------|----------|
| `API_SETUP.md` | API 密钥和配置获取详细步骤 | 新用户 |
| `MOBILE_GUIDE.md` | 手机端使用完整指南 | 移动端用户 |
| `TESTING.md` | 测试清单和验收标准 | 开发者/测试者 |
| `USAGE.md` | 详细使用说明（中文） | 所有用户 |
| `PROJECT_STRUCTURE.md` | 本文件 | 开发者 |

## File Sizes - 文件大小

| File | Size | Description |
|------|------|-------------|
| `jellyfin_tag_filter_pwa.html` | ~40KB | 单文件应用（自包含） |
| `tag_filter_manifest.json` | ~1KB | PWA 元数据 |
| `deploy.ps1` | ~4KB | 部署脚本 |
| All docs | ~30KB | 文档总计 |

**Total Project Size:** < 100KB

## Design Principles - 设计原则

### 1. Single File Application
- 所有代码在一个 HTML 文件中
- 无外部依赖（除 Jellyfin API）
- 易于部署和分发

### 2. Progressive Enhancement
- 基础功能无需 PWA
- PWA 增强用户体验
- 优雅降级支持

### 3. Clean Documentation
- 英文 README 便于国际化
- 中文文档便于本地使用
- 分层文档结构

### 4. Easy Deployment
- 单个脚本自动部署
- 无需编译或构建
- 复制即用

## Development Workflow - 开发流程

### 1. Edit
```
jellyfin_tag_filter_pwa.html
```

### 2. Test Locally
```
Double-click file or use local server
```

### 3. Deploy
```powershell
.\deploy.ps1
```

### 4. Test on Mobile
```
http://SERVER_IP:8096/tag_filter_pwa.html
```

### 5. Update Docs
```
- CHANGELOG.md (version history)
- README.md (if features changed)
- docs/*.md (if usage changed)
```

## Code Organization - 代码组织

### HTML Structure
```html
<head>
    <meta> tags         <!-- PWA configuration -->
    <style>             <!-- All CSS inline -->
</head>
<body>
    <header>            <!-- Top navigation -->
    <config panel>      <!-- Collapsible config -->
    <filter section>    <!-- Tag selection -->
    <results section>   <!-- Grid/List view -->
    <detail overlay>    <!-- Fullscreen player -->
    <script>            <!-- All JavaScript inline -->
</body>
```

### CSS Architecture
```css
:root { --variables }   /* Theme colors */
* { reset }             /* Global reset */
.component { ... }      /* Component styles */
@media { ... }          /* Responsive breakpoints */
```

### JavaScript Modules
```javascript
// State management
let allItems = [];
let selectedTags = new Set();

// API functions
function loadData() {...}
function filterResults() {...}

// UI functions
function renderTags() {...}
function renderResults() {...}

// Player functions
function openInJellyfin() {...}
function closeDetail() {...}
```

## GitHub Best Practices - GitHub 规范

✅ Clear README with badges and examples
✅ Detailed documentation in docs/
✅ Semantic versioning in CHANGELOG
✅ Contributing guidelines
✅ Proper LICENSE file
✅ .gitignore for OS-specific files
✅ .gitattributes for line endings

## Future Enhancements - 未来增强

Potential improvements:
- [ ] Multi-language UI
- [ ] Theme customization
- [ ] Export/import filter presets
- [ ] Playlist support
- [ ] Search by title/year
- [ ] NOT logic (exclude tags)

---

**Maintainability:** Single-file design makes it easy to understand and modify.

