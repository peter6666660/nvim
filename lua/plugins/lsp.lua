-- lsp 相关

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, bufopts)
 
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    filter = function(client)
                        return client.name == "null-ls"
                    end,
                    bufnr = bufnr,
                })
            end,
        })
    end
end

local lua_ls = function (capabilities)
	require'lspconfig'.lua_ls.setup{
     capabilities = capabilities,
     on_attach = on_attach,
		 settings = {
			Lua = {
				 diagnostics = {
            -- 识别 `vim` 是全局变量，避免报错
            globals = {'vim'},
          },
          workspace = {
            -- 使语言服务器识别 Neovim 运行时文件
            library = vim.api.nvim_get_runtime_file("", true),
            -- 对第三方插件和 Neovim 内部文件进行支持
            checkThirdParty = false,
          },
          -- 禁用遥测数据
          telemetry = {
            enable = false,
          }
			}
		}

	}
end

local tsserver = function (capabilities)
  local lspconfig = require('lspconfig')
	lspconfig.tsserver.setup{
     root_dir = lspconfig.util.root_pattern('jsconfig.json', '.git'),
     capabilities = capabilities,
     on_attach = on_attach
  }
end

local vuels = function (capabilities)
  local lspconfig = require('lspconfig')
	lspconfig.vuels.setup{
     capabilities = capabilities,
     on_attach = on_attach
  }
end
local cssls = function (capabilities)
  local lspconfig = require('lspconfig')
	lspconfig.cssls.setup{
     capabilities = capabilities,
     on_attach = on_attach
  }
end
return {
	 -- nvim-lspconfig 用于配置 LSP
	{
		"neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim", -- 管理lsp,formatting 等插件
      "williamboman/mason-lspconfig.nvim", -- 快捷配置
      "hrsh7th/cmp-nvim-lsp",
    },
		config = function()
      require('mason').setup()
			require('mason-lspconfig').setup({
				ensure_installed = {'lua_ls', 'tsserver', 'css-lsp', 'vuels'}, -- 自动安装这些 LSP
			})
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

			tsserver(capabilities)
			lua_ls(capabilities)
      cssls(capabilities)
      vuels(capabilities)
		end
	}
}
