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
					adaptive_size = false,
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
	-- 状态栏
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	opts = {
	-- 		options = {
	-- 			section_separators = "",
	-- 			component_separators = "",
	-- 		},
	-- 	},
	-- },
}
