local M = {}

M.setup = function()
	require("lib.npm_install_async").setup()
	M.create_command()
end

M.create_command = function(name, func)
	vim.api.nvim_create_user_command("LazygitToggle", function()
		require("lib.lazygit").LAZYGIT_TOGGLE()
	end, {})
	vim.api.nvim_create_user_command("ShowBlame", function()
		require("lib.show_blame").ShowBlame()
	end, {})
end

return M
