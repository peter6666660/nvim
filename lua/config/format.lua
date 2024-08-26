local M = {}

M.setup = function()
	-- 格式化文件
	local fileTypeList = vim.g.autoformat_type_list

	for _, value in ipairs(fileTypeList) do
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = value,
			command = "Neoformat",
		})
	end
end

return M
