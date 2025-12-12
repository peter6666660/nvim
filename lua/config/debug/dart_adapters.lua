local M = {}
M.setup = function(dap)
	dap.adapters.dart = function(callback, config)
		callback({ type = "executable", command = "dart", args = { "debug_adapter" } })
	end

	dap.adapters.flutter = function(callback, config)
		callback({ type = "executable", command = "flutter", args = { "debug_adapter" } })
	end

	dap.configurations.dart = {
		{
			type = "flutter", -- 和 adapter 名一致
			request = "launch", -- 也可以是 "attach"
			name = "Launch Flutter",
			program = "${workspaceFolder}/lib/main_dev.dart", -- Flutter 入口
			cwd = "${workspaceFolder}",
		},
	}
end

return M
