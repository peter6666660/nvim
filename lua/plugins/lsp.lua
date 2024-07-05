-- lsp 相关

local lua_ls = function ()
	require'lspconfig'.lua_ls.setup{
		settings = {
			Lua = {
				 diagnostics = {
            -- 识别 `vim` 是全局变量，避免报错
            globals = {'vim'},
          },
          workspace = {
            -- 使语言服务器识别 Neovim 运行时文件
            library = vim.api.nvim_get_runtime_file("", true),
            -- 对第三方插件和 Neovim 内部文件进行支持
            checkThirdParty = false,
          },
          -- 禁用遥测数据
          telemetry = {
            enable = false,
          }
			}
		}

	}
end

local tsserver = function ()
	require'lspconfig'.tsserver.setup{}
end

return {
	 -- nvim-lspconfig 用于配置 LSP
	{
		"neovim/nvim-lspconfig",
		config = function()
			tsserver()
			lua_ls()
		end
	}
}
