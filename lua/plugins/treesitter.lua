return {
	-- 语法高亮
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- 使用最新版本
		-- tag = "v0.9.5",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				fold = {
					enable = true,
				},
				ensure_installed = {
					"embedded_template",
					"bash",
					"c",
					"diff",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"printf",
					"python",
					"query",
					"regex",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
					"vue",
					"scss",
					"css",
				},
				sync_install = false,
				auto_install = true,
				ignore_install = {},
				modules = {},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
			})
			vim.filetype.add({ extension = { ejs = "ejs" } })
			vim.treesitter.language.register("html", "ejs")
			vim.treesitter.language.register("embedded_template", "ejs")
			vim.treesitter.language.register("javascript", "ejs")
		end,
	},
}
