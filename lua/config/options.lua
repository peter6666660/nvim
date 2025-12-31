vim.wo.number = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.g.neovide_transparency = 0.8 -- 设置透明度为 80%

-- 不用 Perl 插件
vim.g.loaded_perl_provider = 0
-- 不用 Ruby 插件
vim.g.loaded_ruby_provider = 0

-- 使用 Nerd Font 图标来代替默认的icon
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_create_augroup("MdxFileType", {})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.mdx",
	command = "set filetype=markdown",
	group = "MdxFileType",
})

local npm_root = vim.fn.system("npm root -g")
local vue_ts_plugin = npm_root .. "/@vue/typescript-plugin"
vim.g.lsp_tsserver_vue_typescript_plugin_path = vue_ts_plugin

--配置折叠方式
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldcolumn = "auto" -- '0' is not bad  显示折叠符号
vim.o.signcolumn = "yes:1" -- 始终显示符号列
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
-- 定义折叠图标
vim.opt.fillchars = {
	foldopen = "", -- 展开
	foldclose = "", -- 折叠
	foldsep = " ", -- 中间分隔
}
