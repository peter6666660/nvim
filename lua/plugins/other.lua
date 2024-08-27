return {
	-- 日历管理
	{ "itchyny/calendar.vim", cmd = "Calendar" },
	-- 注释插件
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring", -- 注释jsx , tsx
		},
		opts = {},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(), -- 注释jsx , tsx
			})
		end,
	},
	-- 快速跳转插件
	{
		"smoka7/hop.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
		config = function()
			require("hop").setup({})
		end,
	},
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
	{
		"voldikss/vim-translator",
		cmd = { "Translate", "TranslateV", "TranslateW", "TranslateWV", "TranslateR", "TranslateRV", "TranslateX" },
		config = function() end,
	},
}
