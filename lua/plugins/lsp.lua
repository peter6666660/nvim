return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		lazy = true,
		config = false,
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" }, -- 自动加载一些插件
			{ "williamboman/mason-lspconfig.nvim" }, -- 简化lsp的配置
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.extend_lspconfig({
				sign_text = true,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			require("mason").setup({})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier", -- JavaScript/TypeScript/CSS/HTML/Markdown 格式化
					"stylua", -- Lua 格式化
					"shfmt", -- Shell 脚本格式化
				},
				automatic_installation = true,
			})
			require("mason-lspconfig").setup({
        automatic_enable = false,
				ensure_installed = { "lua_ls", "ts_ls", "cssls", "marksman", "clangd", "bashls", "pylsp", "tailwindcss" },
				-- 自动加载lsp 先注释
				-- handlers = {
				--   function(server_name)
				--     require("lspconfig")[server_name].setup({})
				--   end,
				-- },
			})

			-- 自定义lsp
			local lspCustomconfig = require("config.lsp")
			lspCustomconfig.setup()
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
