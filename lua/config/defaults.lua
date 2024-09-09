local config_path = vim.fn.stdpath("config") -- 获取nvim 的标准目录路径

local M = {}

-- 文件路径
local primary_path = config_path .. "/lua/config/machine_specific.lua"
local fallback_path = config_path .. "/default_config/_machine_specific_default.lua"

local function file_exists(path, callback)
	vim.loop.fs_stat(path, function(err, stat)
		if err then
			callback(false)
		else
			callback(stat ~= nil)
		end
	end)
end

M.setup = function(callback)
	-- 检查文件是否存在并读取
	file_exists(primary_path, function(exists)
		if not exists then
			local to_config_file = io.open(primary_path, "wb")
			local default_config_file = io.open(fallback_path, "rb")

			if default_config_file and to_config_file then
				local content = default_config_file:read("*all")
				to_config_file:write(content)
				to_config_file:close()
				default_config_file:close()
			end
		end
		require("config.machine_specific")
		vim.defer_fn(function()
			callback()
		end, 100)
	end)
end

return M
