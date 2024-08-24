-- 格式化文件
local fileTypeList = { "*.md", "*.lua" }

return {
	"sbdchd/neoformat",
	init = function()
		vim.g.neoformat_enabled_javascript = { "prettier" }
		vim.g.neoformat_enabled_typescript = { "prettier" }
		vim.g.neoformat_enabled_typescriptreact = { "prettier" }
		vim.g.neoformat_enabled_javascriptreact = { "prettier" }

		vim.g.neoformat_enabled_markdown = { "prettier" }

		for _, value in ipairs(fileTypeList) do
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = value,
				command = "Neoformat",
			})
		end
	end,
}
