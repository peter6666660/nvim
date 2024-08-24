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
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			-- lspsaga 替代
			-- lsp_attach is where you enable features that only work
			-- if there is a language server active in the file
			-- local lsp_attach = function(client, bufnr)
			-- local opts = { buffer = bufnr, noremap = true, silent = true }
			-- lsp_zero.buffer_autoformat()
			-- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
			-- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
			-- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
			-- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
			-- vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
			-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
			-- vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
			-- vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
			-- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
			-- vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			-- end

			lsp_zero.extend_lspconfig({
				sign_text = true,
				-- lsp_attach = lsp_attach,
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
				ensure_installed = { "lua_ls", "tsserver", "cssls", "marksman" },
				-- 自动加载lsp 先注释
				-- handlers = {
				--   function(server_name)
				--     require("lspconfig")[server_name].setup({})
				--   end,
				-- },
			})

			-- 自定义lsp
			local lspCustomconfig = require("config.lsp")
			lspCustomconfig.setup(lsp_zero)
		end,
	},
	--  美化lsp提示
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
		config = function()
			require("lspsaga").setup({})
		end,
	},
}
