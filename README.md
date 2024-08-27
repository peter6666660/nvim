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

### [使用bob关闭neovim版本](https://github.com/MordechaiHadad/bob)

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

### lsp-tsserver

> 识别别名 @, 需要关注 paths 字段和 include 是否配置了后缀

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
