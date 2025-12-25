return {
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
	},
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			require("config.mini").setup()
		end,
	},
}
