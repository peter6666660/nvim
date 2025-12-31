local M = {}

------------------------------------------------------------
-- LSP configs（全部集中在这里）
------------------------------------------------------------
function M.configs()
	return {
		--------------------------------------------------
		-- lua
		--------------------------------------------------
		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		},

		--------------------------------------------------
		-- tsserver
		--------------------------------------------------
		ts_ls = {
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vim.g.lsp_tsserver_vue_typescript_plugin_path,
						languages = { "javascript", "typescript", "vue" },
					},
				},
			},
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"vue",
			},
		},

		--------------------------------------------------
		-- vue_ls
		--------------------------------------------------
		vue_ls = {
			init_options = {
				typescript = {
					tsdk = "node_modules/typescript/lib",
				},
			},
		},

		--------------------------------------------------
		-- css / tailwind
		--------------------------------------------------
		cssls = {
			settings = {
				css = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		},

		tailwindcss = {
			settings = {
				tailwindCSS = {
					classFunctions = { "cva", "clsx", "cn" },
				},
			},
		},

		--------------------------------------------------
		-- python
		--------------------------------------------------
		pylsp = {
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {
							ignore = { "W391" },
							maxLineLength = 200,
						},
						rope_autoimport = {
							enabled = true,
							completions = { enabled = true },
							code_actions = { enabled = true },
						},
						rope_completion = { enabled = true },
					},
				},
			},
		},

		--------------------------------------------------
		-- clangd
		--------------------------------------------------
		clangd = {
			cmd = { "clangd", "--compile-commands-dir=." },
			init_options = {
				fallbackFlags = { "-Iinclude", "-Isrc" },
			},
		},

		--------------------------------------------------
		-- go
		--------------------------------------------------
		gopls = {
			cmd = { "gopls", "serve" },
			settings = {
				gopls = {
					gofumpt = true,
					analyses = {
						unusedparams = true,
						fieldalignment = true,
					},
					staticcheck = true,
					directories = { "src" },
				},
			},
		},

		--------------------------------------------------
		-- simple servers（无需额外配置）
		--------------------------------------------------
		marksman = {},
		bashls = {},
		eslint = {},
		dartls = {},
	}
end

------------------------------------------------------------
-- setup
------------------------------------------------------------
function M.setup()
	local configs = M.configs()

	for name, config in pairs(configs) do
		vim.lsp.config(name, config)
		vim.lsp.enable(name)
	end
end

return M
