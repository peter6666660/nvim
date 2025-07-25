local status, wk = pcall(require, "which-key")
local utils = require("config.utils")
local telescope = require("config.telescope")
if not status then
	return
end

-- noremap = true：禁用递归映射，防止映射命令被其他映射影响，通常是推荐的做法。
-- remap = false：启用递归映射，映射的命令会触发已定义的其他映射。
-- silent = true：执行映射时不会显示命令的输出，避免干扰屏幕输出。

local constants = require("constants")

local M = {}

-- mac 下支持 Cmd+v粘贴
vim.api.nvim_set_keymap("n", "<D-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<D-v>", "<C-r>+", { noremap = true, silent = true })
-- 复制到剪切板
vim.api.nvim_set_keymap("v", "d", '"+d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "p", '"+p', { noremap = true, silent = true })

-- 快速文档中跳转hop插件
vim.api.nvim_set_keymap("n", "s", ":lua require'hop'.hint_words()<CR>", { noremap = true, silent = true })

-- 全局快捷键
local globalMappings = {
	-- 分屏切换
	{ "<C-h>", "<C-w>h", desc = "切换到左分屏", remap = false },
	{ "<C-l>", "<C-w>l", desc = "切换到右分屏", remap = false },
	{ "<C-j>", "<C-w>j", desc = "切换到上分屏", remap = false },
	{ "<C-k>", "<C-w>k", desc = "切换到下分屏", remap = false },
	-- tab
	-- bufferline.nvim 主要用于美化和管理 Neovim 窗口中的缓冲区标签，它不直接控制缓冲区的打开和关闭。
	-- Neovim 的缓冲区是通过 :bd、:bw、:bn 和 :bp 等命令进行管理的。
	{ "<Tab>", ":bn <CR>", desc = "切换到下一个tab" },
	{ "<S-Tab>", ":bp <CR>", desc = "切换到上一个tab" },
	{ "<leader>q", ":q <CR>", desc = "关闭文件", remap = false },
	{ "<leader>w", ":w <CR>", desc = "保存文件", remap = false },

	-- 终端 t 终端模式
	{ "<leader>jk", "<C-\\><C-n>", desc = "退出到终端模式", remap = false, mode = "t" },
	{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "切换终端", remap = false, mode = "n" },
	{
		"<leader>tf",
		"<cmd>lua require('config.terminal').ToggleFloatTerminal()<cr>",
		desc = "切换浮动终端",
		remap = false,
		mode = "n",
	},
	{
		"<leader>df",
		":e" .. constants.DEFAULT_CONFIG_PATH .. "<CR>",
		desc = "编辑默认配置",
		remap = false,
		mode = "n",
	},
	{ "<A-h>", ":vertical resize +5 <CR>", desc = "右调整尺寸", remap = false, mode = "n" },
	{ "<A-l>", ":vertical resize -5 <CR>", desc = "左调整尺寸", remap = false, mode = "n" },
	{ "<A-k>", ":resize +5 <CR>", desc = "上调整尺寸", remap = false, mode = "n" },
	{ "<A-j>", ":resize -5 <CR>", desc = "下调整尺寸", remap = false, mode = "n" },
}
--普通模式下的快捷键
local nMappings = {
	-- 文件树
	{ "<leader>e", ":NvimTreeToggle <CR>", desc = "文件侧边栏(切换)", remap = false },

	-- tab相关
	{ "<leader>b", group = "Tab", remap = false, mode = "n" },
	{ "<leader>bd", ":bd <CR>", desc = "关闭当前的tab", remap = false },
	{ "<leader>bl", ":BufferLineCloseLeft <CR>", desc = "关闭左边的tab", remap = false },
	{ "<leader>br", ":BufferLineCloseRight <CR>", desc = "关闭左边的tab", remap = false },

	-- outline
	{ "<leader>o", "<cmd>Outline<CR>", desc = "打开代码大纲", remap = false, mode = "n" },

	-- 代码相关
	{ "<leader>c", group = "代码相关", remap = false },
	{ "<leader>cf", ":Neoformat <CR>", desc = "格式化代码", remap = false },

	-- 搜索相关Telescope
	{ "<leader>f", group = "搜索文件", remap = false },
	{ "<leader>ff", ":Telescope find_files<CR>", desc = "搜索文件", remap = false },
	-- { "<leader>fg", ":Telescope live_grep<CR>", desc = "查内容", remap = false }, 注释掉使用rg搜索，能支持
	{
		"<leader>fg",
		":Telescope live_grep_args<CR>",
		desc = "全局搜索",
		remap = false,
	},
	{ "<leader>fh", ":Telescope help_tags<CR>", desc = "搜索文档", remap = false },
	{ "<leader>fr", ":Telescope oldfiles<CR>", desc = "最近打开的文件", remap = false },
	{ "<leader>fq", ":Telescope quickfix<CR>", desc = "Quickfix列表(给cfdo使用)", remap = false, mode = "n" },
	{
		"<leader>fd",
		telescope.openDiagnostics,
		desc = "打开诊断信息",
		noremap = true,
		silent = true,
		mode = "n",
	},
	{
		"<leader>fD",
		utils.openDiagnostics,
		desc = "查看诊断信息病复制",
		noremap = true,
		silent = true,
		mode = "n",
	},

	-- git
	{ "<leader>g", group = "Git", remap = false },
	{ "<leader>gg", ":LazygitToggle <CR>", desc = "lazyGit", remap = false },
	{ "<leader>gd", ":Gitsigns diffthis<CR>", desc = "git diff", remap = false, mode = "n" },

	-- markdown view
	-- { "<leader>mv", ":Markview<CR>", desc = "markdown预览切换", remap = false, mode = "n" },

	-- lspsaga.nvim 相关 gd gD gr gk等
	{ "gd", ":Lspsaga goto_definition<CR>", desc = "跳转到定义", remap = false, mode = "n" },
	{ "gD", ":Lspsaga goto_definition<CR>", desc = "跳转到定义的类型", remap = false, mode = "n" },
	{ "gr", ":Lspsaga rename<CR>", desc = "", remap = false, mode = "n" },
	{ "gf", ":Lspsaga finder<CR>", desc = "跳转到引用", remap = false, mode = "n" },
	{ "gk", ":Lspsaga peek_definition<CR>", desc = "预览定义", remap = false, mode = "n" },
	{ "K", ":Lspsaga hover_doc<CR>", desc = "hover doc", remap = false, mode = "n" },
	{
		"<leader>ca",
		":Lspsaga code_action<CR>",
		desc = "如修复错误、优化代码等",
		remap = false,
		mode = { "n", "v" },
	},

	-- 取消高亮
	{ "<leader><CR>", ":nohlsearch<cr>", desc = "取消高亮", remap = false, mode = "n" },

	-- 日历
	{ "\\\\", "<cmd>Calendar<CR>", desc = "hover doc", remap = false, mode = "n" },
	-- 时钟
	{ "\\c", "<cmd>Calendar -view=clock<CR>", desc = "hover doc", remap = false, mode = "n" },
	-- 翻译
	{ "tt", "<cmd>TranslateW<CR>", desc = "翻译", mode = { "n" } },
}

local iMappings = {
	-- mode == i 编辑时触发
	{ "jk", "<ESC>", desc = "退出文件编辑", mode = "i" },
}

local vMappings = {
	-- { "tt", ":'<,'>TranslateW<CR>", desc = "选中翻译", remap = false, mode = "v" },
}

M.setup = function()
	wk.setup()
	wk.add(globalMappings)
	wk.add(iMappings)
	wk.add(vMappings)
	wk.add(nMappings)
end

return M
