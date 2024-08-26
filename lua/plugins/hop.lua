return {
	"smoka7/hop.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
	config = function()
		require("hop").setup({})
	end,
}
