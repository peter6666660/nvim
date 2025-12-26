return {
	{
		"williamboman/mason.nvim",

		dependencies = {
			"williamboman/mason-lspconfig.nvim", -- 简化lsp的配置
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- 自动加载一些插件
		},
		config = function()
			require("config.mason").setup()
		end,
	},
}
