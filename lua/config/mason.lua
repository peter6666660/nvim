local M = {}

M.setup = function()
	require("mason").setup({})
	require("mason-tool-installer").setup({
		ensure_installed = {
			"prettier", -- JavaScript/TypeScript/CSS/HTML/Markdown 格式化
			"stylua", -- Lua 格式化
			"shfmt", -- Shell 脚本格式化
		},
		automatic_installation = true,
	})
	require("mason-lspconfig").setup({
		automatic_enable = false,
		ensure_installed = {
			"lua_ls",
			"ts_ls",
			"cssls",
			"marksman",
			"clangd",
			"bashls",
			"pylsp",
			"ruff",
			"eslint",
		},
		-- 自动加载lsp 先注释
		-- handlers = {
		--   function(server_name)
		--     require("lspconfig")[server_name].setup({})
		--   end,
		-- },
	})
	-- 自定义lsp
	local lspCustomconfig = require("config.lsp")
	lspCustomconfig.setup()
end
return M
