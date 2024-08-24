-- 指定日志文件路径
local log_file = vim.fn.stdpath("data") .. "/nvim_log.txt"

local M = {}

-- 自定义 print 函数
M.info = function(...)
	local args = { ... }
	local file = io.open(log_file, "a") -- 以追加模式打开文件
	if file then
		for _, v in ipairs(args) do
			file:write(vim.inspect(v) .. "\n") -- 使用 vim.inspect 以便打印表格和复杂数据
		end
		file:close()
	end
end

return M
