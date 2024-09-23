# NEOVIM

## 插件

### lazy懒加载控制

| 类型 | key   | 值          | 说明                           |
| ---- | ----- | ----------- | ------------------------------ |
| 事件 | event | BufNewFile  | 打开新文件                     |
| 事件 | event | BufReadPre  | 在开始读取缓冲区内容之前触发。 |
| 事件 | event | BufReadPost | 在缓冲区内容读取完成之后触发。 |
| 命令 | cmd   | <CMD>       | 输入的命令 eg: Telescope       |

### plugins文件管理及说明

| 文件名        | 说明                   |
| ------------- | ---------------------- |
| autopairs.lua | 标签,括号,引号操作相关 |
| format.lua    | 代码格式化相关         |
| git.lua       | git 相关               |
| lsp.lua       | 语言服务器相关         |
| nvim-cmp.lua  | 语法提示相关           |
| telescope.lua | 搜索相关               |
| ui.lua        | 视觉相关               |
| which-key.lua | 快捷键配置             |
| other.lua     | 其他                   |

### 自定义命令

| 命令                   | 说明               | path                  |
| ---------------------- | ------------------ | --------------------- |
| FormatOpenCurrentFile  | 开启当前文件格式化 | lua/config/format.lua |
| FormatCloseCurrentFile | 关闭当前文件格式化 | lua/config/format.lua |

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

### 默认配置

1.  修改 ./lua/config/machine_specific.lua
2.  默认配置在 ./default_config/\_machine_specific_default.lua

| 环境变量                                      | 说明                         |
| --------------------------------------------- | ---------------------------- |
| vim.g.lsp_tsserver_vue_typescript_plugin_path | Vue LSP 支持 script 语法提示 |
| vim.g.autoformat_type_list                    | 配置自动格式化文件类型       |

### 插件列表

| 插件                                                              | 版本            | 作用                   |
| ----------------------------------------------------------------- | --------------- | ---------------------- |
| neovim                                                            | v0.10.0         | -                      |
| VonHeikemen/lsp-zero.nvim                                         | branch = "v4.x" | 简化和配置LSP          |
| [hedyhli/outline.nvim](https://github.com/hedyhli/outline.nvim)   | \*              | 代码大纲               |
| [itchyny/calendar.vim](https://github.com/itchyny/calendar.vim)   | \*              | 日历/时钟              |
| [OXY2DEV/markview.nvim](https://github.com/OXY2DEV/markview.nvim) | v20.1.0         | neovim 中 预览markdown |
| [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify)   | -               | 美化日志提示           |

### 功能列表

- [] AI
- [] DAP
- [x] 支持动态调整splitv 和 文件管理器 的宽度大小
- [x] 支持折叠: nvim-ufo
- [x] notify 美化提示
- [x] 本地化配置文件 - leader + df (打开配置文件)
- [x] 浮动终端 leader + tt | leader + tf
- [x] 管理文件 nvim-tree
- [x] lsp-zero 管理 lsp
- [x] markdown预览 leader + mv
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
  - [] c c++ 配置表格式化

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

### logs

- 2024-09-22 配置文件改为协程管理流程
