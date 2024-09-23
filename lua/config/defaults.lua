local constants = require("constants") -- 默认配置文件

local M = {}

-- 文件路径
local primary_path = constants.DEFAULT_CONFIG_PATH
-- 本地默认配置文件
local fallback_path = constants.DEFAULT_CONFIG_PATH_TEMPLATE

local function file_exists(path)
	local co = coroutine.running()
	vim.loop.fs_stat(path, function(err, stat)
		local exists = not err and stat ~= nil
		coroutine.resume(co, exists)
	end)
	return coroutine.yield() -- 等待协程恢复并返回结果
end

local function copy_default_config()
	local default_config_file = io.open(fallback_path, "rb")
	if not default_config_file then
		return false
	end

	local to_config_file = io.open(primary_path, "wb")
	if not to_config_file then
		default_config_file:close()
		return false
	end

	local content = default_config_file:read("*all")
	to_config_file:write(content)
	to_config_file:close()
	default_config_file:close()
	return true
end

M.setup = function()
	local co = coroutine.create(function()
		if not file_exists(primary_path) then
			if not copy_default_config() then
				print("Failed to copy default config.")
				return false
			end
		end

		local success, err = pcall(require, "config.machine_specific")
		if not success then
			print("Failed to load machine_specific config: " .. err)
			return false
		end

		print("Configuration loaded successfully.")
		return true
	end)

	-- 启动协程
	coroutine.resume(co)

	return co
end
return M
