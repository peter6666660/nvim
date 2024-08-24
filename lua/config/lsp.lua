local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

local M = {}

M.lspNameList = { "tsserver", "marksman", "cssls" }

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

function M.volar()
	lspconfig.volar.setup({
		flags = {
			debounce_text_changes = 150,
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
end

return M
