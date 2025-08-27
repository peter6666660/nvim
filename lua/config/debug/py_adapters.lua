local M = {}
M.setup = function(dap)
	dap.adapters.python = {
		type = "executable",
		command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python", -- 或者 mason 管理的 python 路径
		args = { "-m", "debugpy.adapter" },
	}
	dap.configurations.python = {
		{
			name = "Launch file",
			type = "python",
			request = "launch",
			program = "${file}",
			pythonPath = function()
				return vim.fn.exepath("python")
			end,
		},
	}
end

return M
