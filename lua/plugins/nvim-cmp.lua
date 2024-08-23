-- ~/.config/nvim/lua/plugins/completion.lua
return {
	"hrsh7th/nvim-cmp",
  event = "InsertEnter", -- 只有键入的时候才启动cmp
	dependencies = {
		-- source - 增加lsp的变量
		"hrsh7th/cmp-nvim-lsp",
		-- source - 增加lua的变量 eg: vim.lsp.util
		"hrsh7th/cmp-nvim-lua",
		-- source - 增加buffer 里面的变量
		"hrsh7th/cmp-buffer",
		-- source - 增加系统路径
		"hrsh7th/cmp-path",
		-- source - 提供对 Neovim 命令行模式的补全支持
		"hrsh7th/cmp-cmdline",
		-- 管理和使用代码片段（snippets）的插件
		"L3MON4D3/LuaSnip",
		-- 支持  luasnip 管理的片段集成到 nvim-cmp 的补全菜单中
		"saadparwaiz1/cmp_luasnip",
		-- 预定义的代码片段集合
		"rafamadriz/friendly-snippets",
		-- 美化提示formatting
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		require("luasnip/loaders/from_vscode").lazy_load()
		local lspkind = require("lspkind")

		lspkind.init({
			symbol_map = {
				Text = "  ",
				Method = "  ",
				Function = "  ",
				Constructor = "  ",
				Field = "  ",
				Variable = "  ",
				Class = "  ",
				Interface = "  ",
				Module = "  ",
				Property = "  ",
				Unit = "  ",
				Value = "  ",
				Enum = "  ",
				Keyword = "  ",
				Snippet = "  ",
				Color = "  ",
				File = "  ",
				Reference = "  ",
				Folder = "  ",
				EnumMember = "  ",
				Constant = "  ",
				Struct = "  ",
				Event = "  ",
				Operator = "  ",
				TypeParameter = "  ",
			},
		})

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip" },
				{ name = "path" },
			}, {
				{ name = "buffer" },
			}),
      window = {
         completion = cmp.config.window.bordered(),
         documentation = cmp.config.window.bordered(),
      },
			-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-get-types-on-the-left-and-offset-the-menu
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " "
					kind.menu = "    (" .. (strings[2] or "") .. ")"
					return kind
				end,
			},
		})

		-- / 查找模式补全
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- : 命令行补全
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
