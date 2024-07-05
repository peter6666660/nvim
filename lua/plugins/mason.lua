-- 管理和安装 LSP（语言服务器协议）、DAP（调试适配器协议）、Linter（代码检查器）和 Formatter（代码格式化工具）等开发工具


return {
	{
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end
	},
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require('mason-lspconfig').setup({
				ensure_installed = {'lua_ls', 'tsserver'}, -- 自动安装这些 LSP
			})
		end
	}
}
