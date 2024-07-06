return {
	"sbdchd/neoformat",
	init = function()
		vim.g.neoformat_enabled_javascript = { "prettier" }
		vim.g.neoformat_javascript_prettier = {
			exe = "prettier",
			args = { "--config", vim.fn.expand("~/.prettierrc") },
			stdin = 1,
		}
	end,
}
