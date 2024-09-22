return {
	{
		"sbdchd/neoformat",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.format").setup()
		end,
	},
	{ "junegunn/vim-easy-align" },
}
