return {
	-- 日历管理
	{ "itchyny/calendar.vim", cmd = "Calendar" },
	-- 代码大纲
	{
		"hedyhli/outline.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Outline", "OutlineOpen" },
		config = function()
			require("outline").setup({})
		end,
	},
	-- 翻译工具
	-- {
	-- 	"voldikss/vim-translator",
	-- 	cmd = { "Translate", "TranslateV", "TranslateW", "TranslateWV", "TranslateR", "TranslateRV", "TranslateX" },
	-- 	init = function()
	-- 		vim.g.translator_default_engines = { "bing", "haici", "youdao", "google" }
	-- 	end,
	-- },
	-- markdown 预览
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	lazy = false, -- Recommended
	-- 	ft = "markdown", -- If you decide to lazy-load anyway
	-- 	cmd = "Markview",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- },
}
