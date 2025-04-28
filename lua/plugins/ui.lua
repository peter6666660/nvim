-- ui和布局相关的插件
-- 包括皮肤 目录 tabbar tabline 等等
return {
	-- 皮肤
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	-- 菜单
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-lua/plenary.nvim", -- neo-tree 所需依赖
			"nvim-tree/nvim-web-devicons", -- 可选，提供文件图标支持
			"MunifTanjim/nui.nvim", -- neo-tree 所需的 UI 库
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		config = function()
			require("nvim-tree").setup({
				git = {
					ignore = false,
				},
				-- 目录中展示当前文件
				update_focused_file = {
					enable = true,
					update_cwd = true, -- 展示当前的目录
					ignore_list = {},
				},
				view = {
					width = 45,
				},
			})
		end,
	},
	-- tab
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup()
		end,
	},
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
		end,
	},
	-- 状态栏
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				section_separators = "",
				component_separators = "",
			},
		},
	},
	-- 只有这个版本可用(tag = 3.3.11)
	-- 缩进线
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		tag = "v3.3.11",
		config = function()
			require("ibl").setup({})
		end,
	},
	-- TODO: 高亮TODO
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	-- 左上角错误提示
	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	config = function()
	-- 		vim.notify = require("notify")
	-- 	end,
	-- },
}
