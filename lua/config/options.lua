vim.wo.number = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.g.neovide_transparency = 0.8 -- 设置透明度为 80%

--配置折叠方式
vim.o.foldenable = true -- 开启折叠
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldcolumn = "2" -- '0' is not bad  显示折叠符号
vim.o.signcolumn = "yes" -- 始终显示符号列
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

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

vim.api.nvim_create_user_command("LazygitToggle", function()
	require("lib.lazygit").LAZYGIT_TOGGLE()
end, {})

vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DapBreakpoint",
	linehl = "DapBreakpointLine",
	numhl = "DapBreakpointNum",
})

vim.fn.sign_define("DapBreakpointCondition", {
	text = "◆",
	texthl = "DapBreakpointCondition",
	linehl = "DapBreakpointConditionLine",
	numhl = "DapBreakpointConditionNum",
})

vim.fn.sign_define("DapLogPoint", {
	text = "◆",
	texthl = "DapLogPoint",
	linehl = "DapLogPointLine",
	numhl = "DapLogPointNum",
})

vim.fn.sign_define("DapStopped", {
	text = "▶",
	texthl = "DapStopped",
	linehl = "DapStoppedLine",
	numhl = "DapStoppedNum",
})

vim.cmd([[
  highlight DapBreakpoint guifg=#ff0000 guibg=NONE gui=bold
  highlight DapBreakpointLine guibg=#ffcccc
  highlight DapBreakpointNum guifg=#ff0000

  highlight DapBreakpointCondition guifg=#ffcc00 guibg=NONE gui=bold
  highlight DapBreakpointConditionLine guibg=#fff5cc
  highlight DapBreakpointConditionNum guifg=#ffcc00

  highlight DapLogPoint guifg=#00ff00 guibg=NONE gui=bold
  highlight DapLogPointLine guibg=#ccffcc
  highlight DapLogPointNum guifg=#00ff00

  highlight DapStopped guifg=#0000ff guibg=NONE gui=bold
  highlight DapStoppedLine guibg=#ccccff
  highlight DapStoppedNum guifg=#0000ff
]])
