-- 检查 Neovim 版本是否至少为 x.xx.x
-- local function check_minimum_version(major, minor, patch)
-- 	local version = vim.version()
-- 	if
-- 		version.major < major
-- 		or (version.major == major and version.minor < minor)
-- 		or (version.major == major and version.minor == minor and version.patch < patch)
-- 	then
-- 		vim.api.nvim_err_writeln(
-- 			"Neovim version " .. major .. "." .. minor .. "." .. patch .. " or higher is required!"
-- 		)
--
-- 		vim.defer_fn(function()
-- 			vim.cmd("quit")
-- 		end, 1000)
-- 	else
-- 		require("config.lazy")
-- 	end
-- end

-- 默认配置
require("config.defaults")

-- 设定最低版本为 0.10.0
-- check_minimum_version(0, 6, 0)
require("config.lazy")
