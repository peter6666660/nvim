vim.wo.number = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.g.neovide_transparency = 0.8 -- 设置透明度为 80%

-- 配置折叠方式
vim.o.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldcolumn = "0" -- '0' is not bad
vim.opt.signcolumn = "yes" -- 始终显示符号列
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

-- 使用 Nerd Font 图标来代替默认的icon
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
