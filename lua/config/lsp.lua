local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

local M = {}

function M.lua_ls()
	lspconfig.lua_ls.setup({
		settings = {
			Lua = {
				diagnostics = {
					-- 识别 `vim` 是全局变量，避免报错
					globals = { "vim" },
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
				},
			},
		},
	})
end

function M.tsserver()
	lspconfig.tsserver.setup({})
end

function M.cssls()
	lspconfig.cssls.setup({
		filetypes = {
			"css",
			"scss",
			"sass",
			"less",
		},
	})
end

function M.volar()
	lspconfig.volar.setup({
		flags = {
			debounce_text_changes = 150,
		},
	})
end

function M.setup(lsp)
  lspconfig.marksman.setup{}
	M.lua_ls()
	M.tsserver()
	M.volar()
	M.cssls()
end

return M
