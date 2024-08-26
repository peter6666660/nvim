return {
	"sbdchd/neoformat",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("config.format").setup()
	end,
}
