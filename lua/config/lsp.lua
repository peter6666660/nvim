local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

local M = {}

M.lspNameList = { "marksman", "cssls", "clangd" }

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
-- tsserver
function M.ts_ls()
	lspconfig.ts_ls.setup({
		init_options = {
			plugins = {
				-- 支持vue3
				{
					name = "@vue/typescript-plugin",
					location = vim.g.lsp_tsserver_vue_typescript_plugin_path,
					languages = { "javascript", "typescript", "vue" },
				},
			},
		},
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"vue",
		},
	})
end

-- vue
function M.volar()
	lspconfig.volar.setup({
		init_options = {
			typescript = {
				tsdk = "node_modules/typescript/lib",
			},
		},
	})
end

function M.setup(lsp)
	-- 自动加载配置的lsp
	for _, value in ipairs(M.lspNameList) do
		if lspconfig[value] ~= nil then
			lspconfig[value].setup({})
		end
	end

	-- 手动配置的lsp
	M.lua_ls()
	M.volar()
	M.ts_ls()
end

return M
