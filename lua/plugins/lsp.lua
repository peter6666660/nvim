return {
	-- LSP 基础
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		config = function()
			-- LSP configuration now handled in mason.lua
		end,
	},
	--  美化lsp提示
	{
		"nvimdev/lspsaga.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
		config = function()
			require("lspsaga").setup({
				diagnostic = {
					show_code_action = false, -- 关闭重复显示
					keys = {
						quit = "<Esc>",
					},
				},
			})
		end,
	},
}
