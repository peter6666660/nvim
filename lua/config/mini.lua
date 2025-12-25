local M = {}

M.setup = function()
	require("mini.jump2d").setup({})
	require("mini.surround").setup({})
	require("mini.indentscope").setup({})
	require("mini.cursorword").setup({})
	require("mini.git").setup()
	require("mini.statusline").setup({})
	require("mini.files").setup({})

	M.hipatterns() -- TODO: 高亮
	M.diff()
	M.comment()
end

M.diff = function()
	require("mini.diff").setup({
		view = {
			style = "sign",
			signs = { add = "+", change = "~", delete = "-" },
		},
		mappings = {
			-- Apply hunks inside a visual/operator region
			apply = "", -- gh

			-- Reset hunks inside a visual/operator region
			reset = "", -- gH

			-- Hunk range textobject to be used inside operator
			-- Works also in Visual mode if mapping differs from apply and reset
			textobject = "", -- gh

			-- Go to hunk range in corresponding direction
			goto_first = "", -- [H
			goto_prev = "", -- [h
			goto_next = "", -- ]h
			goto_last = "", -- ]H
		},
	})
end

M.comment = function()
	require("mini.comment").setup({
		options = {
			custom_commentstring = function()
				return require("ts_context_commentstring.internal").calculate_commentstring()
			end,
		},
	})
end

M.hipatterns = function()
	require("mini.hipatterns").setup({
		highlighters = {
			-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
			fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
			hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
			todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
			note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		},
	})
end

return M
