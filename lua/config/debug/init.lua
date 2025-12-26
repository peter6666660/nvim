local M = {}
M.dap = require("dap")
M.dapui = require("dapui")

-- TODO: set adapters
M.set_adapters = function(dap)
	require("config.debug.py_adapters").setup(dap)
	require("config.debug.lua_adapters").setup(dap)
	require("config.debug.dart_adapters").setup(dap)
end

function M.setup()
	M.set_options()
	--  DAP-UI
	M.set_dapui(M.dapui, M.dap)

	-- set adapters
	M.set_adapters(M.dap)
end

M.set_dapui = function(dapui, dap)
	dapui.setup({
		layouts = {
			{
				elements = {
					"scopes",
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40,
				position = "right",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 0.25,
				position = "bottom",
			},
		},
	})

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
M.dapui_toggle = function()
	M.dapui.toggle()
end

M.dapui_reset = function()
	M.dapui.close()
	M.dapui.toggle({ reset = true })
end

M.set_options = function()
	vim.fn.sign_define("DapBreakpoint", {
		text = "🐞",
		-- 	text = "●",
		-- 	texthl = "DapBreakpoint",
		-- linehl = "DapBreakpointLine",
		-- numhl = "DapBreakpointNum",
	})

	vim.fn.sign_define("DapBreakpointCondition", {
		text = "◆",
		texthl = "DapBreakpointCondition",
		linehl = "DapBreakpointConditionLine",
		numhl = "DapBreakpointConditionNum",
	})

	vim.fn.sign_define("DapLogPoint", {
		text = "◆",
		texthl = "DapLogPoint",
		linehl = "DapLogPointLine",
		numhl = "DapLogPointNum",
	})

	vim.fn.sign_define("DapStopped", {
		text = "▶",
		texthl = "DapStopped",
		linehl = "DapStoppedLine",
		numhl = "DapStoppedNum",
	})

	vim.cmd([[
    highlight DapBreakpoint guifg=#ff0000 guibg=NONE gui=bold
    highlight DapBreakpointLine guibg=#ffcccc
    highlight DapBreakpointNum guifg=#ff0000

    highlight DapBreakpointCondition guifg=#ffcc00 guibg=NONE gui=bold
    highlight DapBreakpointConditionLine guibg=#fff5cc
    highlight DapBreakpointConditionNum guifg=#ffcc00

    highlight DapLogPoint guifg=#00ff00 guibg=NONE gui=bold
    highlight DapLogPointLine guibg=#ccffcc
    highlight DapLogPointNum guifg=#00ff00

    highlight DapStopped guifg=#0000ff guibg=NONE gui=bold
    highlight DapStoppedLine guibg=#ccccff
    highlight DapStoppedNum guifg=#0000ff
  ]])
end
return M
