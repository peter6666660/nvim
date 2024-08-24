return {
	-- 高亮markdown
	-- { "preservim/vim-markdown", ft = { "markdown" } },
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown", -- If you decide to lazy-load anyway
		tag = "v20.1.0",
		dependencies = {
			-- You will not need this if you installed the
			-- parsers manually
			-- Or if the parsers are in your $RUNTIMEPATH
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		-- config = function()
		-- 	require("markview").setup({
		-- 		headings = {
		-- 			enable = true,
		--
		-- 			heading_1 = {
		-- 				style = "label",
		--
		-- 				padding_left = " ",
		-- 				padding_right = " ",
		--
		-- 				hl = "MarkviewHeading1",
		-- 			},
		-- 		},
		-- 	})
		-- end,
	},
}
