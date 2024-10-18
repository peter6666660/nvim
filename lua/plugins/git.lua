return {
	{

		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { test = "_" },
					topdelete = { test = "‾" },
					changedelete = { test = "~" },
				},
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 3000,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},
	-- diff view
	{ "sindrets/diffview.nvim" },
}
