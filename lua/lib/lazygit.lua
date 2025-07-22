local M = {}
M.Terminal = require("toggleterm.terminal").Terminal
M.lazygit = M.Terminal:new({
	cmd = "lazygit",
	dir = "git_dir", -- 在项目根目录启动
	direction = "float",
	float_opts = {
		border = "double",
	},
	hidden = true, -- 不通过 :ToggleTerm 显示
	on_open = function(term)
		vim.cmd("startinsert")
		-- Esc 关闭浮动窗口
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
	on_close = function(_)
		vim.cmd("startinsert")
	end,
})

function M.LAZYGIT_TOGGLE()
	M.lazygit:toggle()
end

return M
