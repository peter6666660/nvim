return {
	"sbdchd/neoformat",
	init = function()
		vim.g.neoformat_enabled_javascript = { "prettier" }
		vim.g.neoformat_enabled_typescript = { "prettier" }
		vim.g.neoformat_enabled_typescriptreact = { "prettier" }
		vim.g.neoformat_enabled_javascriptreact = { "prettier" }
	end,
}
