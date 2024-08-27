return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-autopairs").setup({})
			-- 启用对 HTML 文件的自动闭合
			require("nvim-ts-autotag").setup()
		end,
	},
	-- 可以最快选中 ' " { (  的内容
	{ "gcmt/wildfire.vim", event = { "BufReadPre", "BufNewFile" } },
	-- 快速选中变量 c-n 类似 vscode 的 c-d
	{ "mg979/vim-visual-multi", event = { "BufReadPre", "BufNewFile" } },
	-- 替换“ { } ()
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
}
