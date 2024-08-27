local M = {}
local autocmd_map = {} -- 用来保存创建的自动命令的映射关系

-- 公共方法：创建自动命令
M.create_autocmd = function(pattern)
	local id = vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = pattern,
		command = "Neoformat",
	})
	return id
end

M.create_autocmd_for_extension = function(extension)
	local pattern = "*." .. extension -- 拼接成 "*.extension"
	return M.create_autocmd(pattern)
end

-- 添加命令到 Neovim
M.setCMD = function()
	vim.api.nvim_create_user_command("FormatOpenCurrentFile", function()
		M.add_autocmd_for_current_file()
	end, {})

	vim.api.nvim_create_user_command("FormatCloseCurrentFile", function()
		M.remove_autocmd_for_current_file()
	end, {})
end

-- 创建自动命令的函数
M.setup = function()
	M.setCMD()
	-- 格式化文件
	local fileTypeList = vim.g.autoformat_type_list

	-- 清除之前的自动命令，防止重复创建
	M.remove_autocmds()

	for _, value in ipairs(fileTypeList) do
		local id = M.create_autocmd_for_extension(value)
		autocmd_map[value] = id -- 保存 value 和自动命令 ID 的映射关系
	end
end

-- 添加当前文件类型的自动命令
M.add_autocmd_for_current_file = function()
	local filetype = vim.fn.expand("%:e") -- 获取当前文件的扩展名
	if filetype == "" then
		print("No file extension found for current file.")
		return
	end

	-- 先删除旧的自动命令（如果存在）
	M.remove_autocmd(filetype)

	-- 创建新的自动命令
	local id = M.create_autocmd("*." .. filetype)
	autocmd_map[filetype] = id -- 保存新的映射
end

-- 关闭指定文件类型的自动命令
M.remove_autocmd = function(value)
	local id = autocmd_map[value]
	if id then
		vim.api.nvim_del_autocmd(id) -- 删除自动命令
		autocmd_map[value] = nil -- 移除映射
	else
		print("No autocmd found for pattern:", value)
	end
end

-- 关闭当前文件类型的自动命令
M.remove_autocmd_for_current_file = function()
	local filetype = vim.fn.expand("%:e") -- 获取当前文件的扩展名
	M.remove_autocmd(filetype)
end

-- 关闭所有自动命令
M.remove_autocmds = function()
	for value, id in pairs(autocmd_map) do
		vim.api.nvim_del_autocmd(id) -- 删除自动命令
	end
	autocmd_map = {} -- 清空映射
end

return M
