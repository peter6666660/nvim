return {
	{
		"hedyhli/outline.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Outline", "OutlineOpen" },
		config = function()
			require("outline").setup({})
		end,
	},
}
