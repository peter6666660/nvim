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
		-- automatic_enable = false,
		ensure_installed = {
			"lua_ls",
			"ts_ls",
			"vue_ls",
			"cssls",
			"tailwindcss",
			"marksman",
			"clangd",
			"gopls",
			"bashls",
			"pylsp",
			"eslint",
			"dartls",
		},
		handlers = {
			function(server_name)
				local lspconfig = require("lspconfig")
				local configs = require("config.lsp").configs()
				local config = configs[server_name] or {}
				lspconfig[server_name].setup(config)
			end,
		},
	})
	-- LSP now handled by mason-lspconfig handlers above
end
return M
