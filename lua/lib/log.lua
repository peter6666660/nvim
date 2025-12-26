local M = {}

-- 指定日志文件路径
-- local log_file = vim.fn.stdpath("data") .. "/nvim_log.txt"
-- -- 自定义 print 函数
-- M.info = function(...)
-- 	local args = { ... }
-- 	local file = io.open(log_file, "a") -- 以追加模式打开文件
-- 	if file then
-- 		for _, v in ipairs(args) do
-- 			file:write(vim.inspect(v) .. "\n") -- 使用 vim.inspect 以便打印表格和复杂数据
-- 		end
-- 		file:close()
-- 	end
-- end

local log_path = vim.fn.expand("~/.logs/neovim_debug.log")

-- 带时间的日志追加函数
M.log_debug = function(data)
	-- 获取 ISO 8601 格式时间（示例: 2024-05-20T15:30:45）
	local timestamp = os.date("%Y-%m-%dT%H:%M:%S")

	-- 确保目录存在
	local dir = vim.fn.fnamemodify(log_path, ":h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p", 0755) -- 递归创建目录
	end

	-- 安全写入文件
	local file, err = io.open(log_path, "a") -- 追加模式
	if not file then
		vim.notify("无法写入日志文件: " .. err, vim.log.levels.ERROR)
		return
	end

	-- 构造日志内容
	local log_content = string.format(
		"[%s]\n%s\n\n", -- 添加空行分隔
		timestamp,
		vim.inspect(data) -- 自动格式化对象
	)

	-- 写入并关闭
	file:write(log_content)
	file:close()
end

return M
