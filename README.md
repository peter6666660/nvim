## 插件版本

### 插件列表

| 插件                      | 版本            | 作用          |
| ------------------------- | --------------- | ------------- |
| neovim                    | ^0.10.1         | -             |
| VonHeikemen/lsp-zero.nvim | branch = "v4.x" | 简化和配置LSP |

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
