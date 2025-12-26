# My NEOVIM

## Neovim

### [使用bob管理neovim版本](https://github.com/MordechaiHadad/bob)

```bash
cargo install --git https://github.com/MordechaiHadad/bob.git

# 会提示一些命令
bob

# 下载neovim 版本
bob install 0.10.0
# 使用某个版本
bob use 0.10.0
# 查看有哪些版本
bob list

# 目录会安装到 ~/.local/share/bob/nvim-bin/nvim
# 自行去link



```

### 常用模式对应命令

| 模式     | 命令   | 描述           |
| -------- | ------ | -------------- |
| 普通模式 | `nmap` | normal mode    |
| 插入模式 | `imap` | insert mode    |
| 可视模式 | `vmap` | visual mode    |
| 终端模式 | `tmap` | terminal mode  |
| 所有模式 | `map`  | 所有模式都显示 |

### 查某模式下某个按键的映射

```sh
# nmap：普通模式映射
:verbose nmap <key> # :verbose nmap g
:verbose imap <Tab>

```

## lazy.vim

### lazy懒加载控制

| 类型 | key   | 值                                                 | 说明                                                                        |
| ---- | ----- | -------------------------------------------------- | --------------------------------------------------------------------------- |
| 事件 | event | BufNewFile                                         | 打开新文件                                                                  |
| 事件 | event | BufReadPre                                         | 在开始读取缓冲区内容之前触发。                                              |
| 事件 | event | BufReadPost                                        | 在缓冲区内容读取完成之后触发。                                              |
| 事件 | event | BufEnter, BufWinEnter, FileType, Syntax , VimEnter | Autocmd事件                                                                 |
| 事件 | event | VeryLazy                                           | 在UIEnter只有通过vim.schedule发出VeryLazy事件，适合那些不影响收评渲染的插件 |
| 命令 | cmd   | <CMD>                                              | 输入的命令 eg: Telescope                                                    |

## 我的自定义

### 文件树

├── ftplugin
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config // 配置文件
│   ├── constants.lua // 常量文件[没用到]
│   ├── lib // 自己写的一些工具函数
│   ├── myhealth // 自定义的健康检查
│   └── plugins // 插件管理
├── mcpServers.json // 没用到
├── MINI.md // mini.nvim 说明
└── README.md // 说明

### 替换的插件

| 新               | 旧                                  | 说明                                              |
| ---------------- | ----------------------------------- | ------------------------------------------------- |
| mini.jump2d      | smoka7/hop.nvim                     | 跳转                                              |
| mini.comment     | numToStr/Comment.nvim               | 注释                                              |
| mini.diff        | lewis6991/gitsigns.nvim             | 可视化 diff / 差异工具                            |
| mini.surround    | kylechui/nvim-surround              | Add, delete, replace, find, highlight surrounding |
| mini.indentscope | lukas-reineke/indent-blankline.nvim | 缩进线                                            |
| mini.statusline  | nvim-lualine/lualine.nvim           | 状态栏                                            |
| mini.hipatterns  | folke/todo-comments.nvim            | 模式高亮（如 TODO / FIXME）                       |
| mini.cursorword  | --                                  | 光标词高亮                                        |
| mini.git         | --                                  | Git 相关集成                                      |

### 放弃替换的插件

| 新         | 旧                      | 说明                             |
| ---------- | ----------------------- | -------------------------------- |
| mini.files | nvim-tree/nvim-tree.lua | 文件浏览 & 编辑 🗂 (不能git高亮) |

## 插件

### 快捷键说明

| 快捷键                          | 说明                               |
| ------------------------------- | ---------------------------------- |
| Control + h                     | 切换到左分屏                       |
| Control + l                     | 切换到右分屏                       |
| Control + j                     | 切换到上分屏                       |
| Control + k                     | 切换到下分屏                       |
| (Option/Alt) + 方向键(上下左右) | 调整分屏尺寸                       |
| <Tab>                           | 切换下一个Tab                      |
| Shift + <Tab>                   | 切换上一个Tab                      |
| <leader>tt                      | 切换终端小窗口                     |
| <leader>tf                      | 切换浮动终端                       |
| <leader>jk                      | 退出到终端模式                     |
| <leader>w                       | 保存文件                           |
| <leader>q                       | 关闭文件                           |
| <leader>fd                      | 通过telescope 查看缓存区的所有诊断 |
| <leader>fD                      | vim浮窗查看当前诊断并复制到剪切板  |

### 自定义命令

| 命令                   | 说明                    | path                   |
| ---------------------- | ----------------------- | ---------------------- |
| FormatOpenCurrentFile  | 开启当前文件格式化      | lua/config/format.lua  |
| FormatCloseCurrentFile | 关闭当前文件格式化      | lua/config/format.lua  |
| ShowBlame              | 查看当前文件的git blame | lua/lib/show_blame.lua |
| LazygitToggle          | 切换lazygit             | lua/lib/lazygit.lua    |

### lib

| 文件                          | 说明                  |
| ----------------------------- | --------------------- |
| lua/lib/npm_install_async.lua | 一些自定义的npm依赖包 |

### plugins文件管理及说明

| 文件名        | 说明                          |
| ------------- | ----------------------------- |
| ai.lua        | AI                            |
| autopairs.lua | 标签,括号,引号操作相关        |
| debug.lua     | 调试相关 (nvim-dap)           |
| format.lua    | 代码格式化相关                |
| lsp.lua       | 语言服务器相关                |
| mason.lua     | lsp,dap,formatter, linter管理 |
| mini.lua      | 小插件集合                    |
| nvim-cmp.lua  | 语法提示相关                  |
| nvim-ufo.lua  | 折叠功能                      |
| telescope.lua | 搜索相关                      |
| terminal      | 终端相关                      |
| ui.lua        | 视觉相关                      |
| which-key.lua | 快捷键配置                    |
| other.lua     | 其他                          |

### 默认配置

1.  修改 ./lua/config/machine_specific.lua
2.  默认配置在 ./default_config/\_machine_specific_default.lua

| 环境变量                                      | 说明                         |
| --------------------------------------------- | ---------------------------- |
| vim.g.lsp_tsserver_vue_typescript_plugin_path | Vue LSP 支持 script 语法提示 |
| vim.g.autoformat_type_list                    | 配置自动格式化文件类型       |

### 插件列表

| 插件                                                            | 版本            | 作用               |
| --------------------------------------------------------------- | --------------- | ------------------ |
| neovim                                                          | v0.10.0         | -                  |
| VonHeikemen/lsp-zero.nvim                                       | branch = "v4.x" | 简化和配置LSP      |
| [hedyhli/outline.nvim](https://github.com/hedyhli/outline.nvim) | \*              | 代码大纲           |
| [itchyny/calendar.vim](https://github.com/itchyny/calendar.vim) | \*              | 日历/时钟          |
| [yetone/avante.nvim](https://github.com/yetone/avante.nvim)     | -               | 对接本地ollama api |

### 功能列表

- [] 自定义代片段
- [] notify 美化提示 (不需要)
- [x] DAP
- [-] AI 辅助开发
  - [x] windsurf
  - [] ollama
- [x] 支持动态调整splitv 和 文件管理器 的宽度大小
- [x] 支持折叠: nvim-ufo
- [-] 单词翻译 leader + tt (注释了)
- [x] 本地化配置文件 - leader + df (打开配置文件)
- [x] 浮动终端 leader + tt | leader + tf
- [x] 管理文件 nvim-tree
- [x] lsp-zero 管理 lsp
- [-] markdown预览 leader + mv 废弃
- [x] [自定义命令](#自定义命令)
- [x] telescope
  - [x] 搜索文件、历史记录、文档
  - [x] 支持正则搜索 leader + fg
- [x] 代码大纲
- [x] lazygit
- [x] 自动格式化 - 需要配置conifg
- [x] 状态栏
- [x] 缩进线
- [x] 注释 gcc
- [x] TODO 高亮 eg: // TODO:"aaa"
- [x] which-key 管理快捷键
- [x] nvim-treesitter 管理 语法高亮
- [x] tab切换文件缓冲区(bufferline)
- [-] LSP
  - [x] TS vue js
  - [x] lsp语法错误提示 ts 会重复，而且不能复制
  - [x] lsp诊断信息支持telescope查看，和浮窗查看并粘贴 (leader + fd | leader+fD)
  - [] c c++ 配置表格式化
- [x] Mason
  - [x] 需要支持自动下载Format插件 比如： js, lua 的format, markdown
- [x] neovim 粘贴的时候,会自动注释和合并 -- bug

### lsp-tsserver

> 识别 @, 需要关注 paths 字段和 include 是否配置了后缀

```json
{
  "compilerOptions": {
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
```

### Telescope - 全局替换

- Telescope live_grep 搜索选中要修改的文件
- Ctrl + q 把搜索文件保存到 quickfix中
- cdo | cfdo 进行替换 eg: cdo /oldText/newText/g | update

### 配置checkhealth

- 规范: /nvim/lua/**/**/health.lua
- eg: myhealth/npm/health.lua

### 常见问题

- 如果碰到ts正则语法提示错误导致高亮识别，优先清除缓存
  - rm -rf ~/.cache/nvim
  - rm -rf ~/.local/share/nvim
- lsp虚拟文本是不支持换行的

### logs

- 2025-12-26 used mini.nvim
- 2025-04-24 增加ai + mcp
- 2024-09-22 配置文件改为协程管理流程

## 引用

### Debug

- https://tamerlan.dev/a-guide-to-debugging-applications-in-neovim/
