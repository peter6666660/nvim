### AvanteProvider

定义位置：lua/avante/config.lua 中的 BASE_PROVIDER_KEYS 列表，以及 [Custom providers Wiki 文档]​
GitHub
GitHub
。

常见字段（BASE_PROVIDER_KEYS）

| 字段               | 类型         | 含义与用途                                                      |
| ------------------ | ------------ | --------------------------------------------------------------- |
| endpoint           | string       | 服务地址前缀，用于构造最终请求 URL。                            |
| model              | string       | 模型名称或部署标识（如 OpenAI 的模型名、Azure 的 deployment）。 |
| api_key_name       | string       | 从环境变量中读取 API Key 的变量名（如 "OPENAI_API_KEY"）。      |
| extra_headers      | table        | 额外 HTTP headers，合并后发送到服务端                           |
| proxy              | string\|nil  | 可选的 HTTP 代理地址（如 "http://127.0.0.1:7890"）。            |
| allow_insecure     | boolean\|nil | 是否允许不安全的 TLS 连接（对应 curl 的 -k/--insecure）。       |
| timeout            | number       | 请求超时时间（毫秒）。                                          |
| temperature        | number\|nil  | 生成温度（仅部分提供者支持，如 OpenAI、Claude）。               |
| max_tokens         | number\|nil  | 最大生成 token 数。                                             |
| \_\_inherited_from | string\|nil  | 继承自哪个内置提供者，便于快速创建“OpenAI 兼容”新厂商。         |
| disable_tools      | boolean\|nil | 是否在请求中禁用工具调用。                                      |
| options            | table        | nil\|Ollama 专用字段：{ temperature, num_ctx, keep_alive }。    |

### AvantePromptOptions

```lua
---@type AvantePromptOptions
return {
  system_prompt             = system_prompt,           -- 初始 system 消息（string）
  messages                  = messages,                -- 对话历史列表（{ role:string, content:string|table }[]）
  image_paths               = image_paths,             -- 图片路径列表（string[]）
  tools                     = tools,                   -- 可调用工具 schema 列表（AvanteLLMToolPublic[]）
  tool_histories            = tool_histories,          -- 已执行工具历史，用于多轮工具链调用
  dropped_history_messages  = dropped_history_messages,-- 因长度超限被丢弃的消息
}
```

```text
system_prompt：系统提示，作为第一条消息。

messages：内嵌 Chat Message 数组；每项 { role="user"|"assistant"|"tool"|…, content=… }。

image_paths：可选，支持将本地图片转为 base64 嵌入。

tools, tool_histories：在多轮工具调用时，记录工具 schema 与历史结果，供后续 parse_messages 补充。

dropped_history_messages：当对话太长，超出 token 限制时，被裁剪掉的旧消息列表。

注意：在自定义 Provider 文档中，code_opts（即本例中 AvantePromptOptions）还会包含

question: 用户的自然语言输入

code_lang: 当前 buffer 语言

code_content: 整个文件内容

selected_code_content: 视觉模式下选中的代码块
```

### AvanteCurlOutput

```lua
---@type AvanteCurlOutput
return {
  url      = "https://.../chat/completions", -- HTTP 请求 URL (string)
  headers  = { ["Content-Type"]="application/json", ... }, -- HTTP Header 表 (table<string,string>)
  proxy    = provider_conf.proxy,               -- 可选代理 (string|nil)
  insecure = provider_conf.allow_insecure,      -- 允许不安全 TLS (boolean|nil)
  body     = {                                  -- 请求体，后续写入临时文件再传给 curl
    model      = "...",
    messages   = {...},
    stream     = true,
    tools      = {...},                        -- 可选：工具定义列表
    timeout    = 30000,                        -- 可选：timeout 字段合并
    temperature= 0,                            -- 可选：合并自 request_body
    max_tokens = 2048,                         -- 可选：合并自 request_body
    -- …其它 provider-specific 字段…
  },
  rawArgs  = {...},                             -- 可选：直接传递给 curl 的原始参数列表 (table|string[]|nil)
}

```

```
url：REST 或 SSE 端点，由 endpoint 与路径拼接而成。​
GitHub

headers：在 curl.post(..., { headers = spec.headers, ... }) 中使用。​
GitHub

proxy、insecure：同名传给 curl。​
GitHub

body：写入临时 JSON 文件，再通过 body = curl_body_file 参数发送。​
GitHub

rawArgs：当某些 Provider 需要特殊 curl 标记时，可直接在此字段中附加。
```
