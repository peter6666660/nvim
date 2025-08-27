local M = {}
M.dap = require("dap")

M.set_adapters = function(dap)
	require("config.debug.py_adapters").setup(dap)
	require("config.debug.lua_adapters").setup(dap)
end

function M.setup()
	local dapui = require("dapui")
	-- DAP-UI
	M.set_dapui(dapui, M.dap)

	-- KEYMAPS
	vim.keymap.set("n", "<F5>", M.continue, { desc = "DAP Continue/Start" })
	vim.keymap.set("n", "<F9>", M.step_into, { desc = "DAP Step Into" })
	vim.keymap.set("n", "<F10>", M.step_over, { desc = "DAP Step Over" })
	vim.keymap.set("n", "<F12>", M.step_out, { desc = "DAP Step Out" })
	vim.keymap.set("n", "<leader>b", M.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
	vim.keymap.set("n", "<leader>B", function()
		M.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end, { desc = "DAP Conditional Breakpoint" })
	vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI Toggle" })

	-- set adapters
	M.set_adapters(M.dap)
end

M.set_dapui = function(dapui, dap)
	dapui.setup()

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

M.debug_neovim = function()
	require("osv").launch({ port = 8086 })
end

M.continue = function()
	M.dap.continue()
end

M.step_into = function()
	M.dap.step_into()
end
M.step_over = function()
	M.dap.step_over()
end
M.step_out = function()
	M.dap.step_out()
end
M.toggle_breakpoint = function(condition)
	M.dap.toggle_breakpoint(condition)
end

return M
