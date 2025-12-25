local M = {}

M.setup = function()
	vim.api.nvim_create_user_command("LazygitToggle", function()
		require("lib.lazygit").LAZYGIT_TOGGLE()
	end, {})
	vim.api.nvim_create_user_command("ShowBlame", function()
		require("lib.show_blame").ShowBlame()
	end, {})
end

return M
