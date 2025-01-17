local M = {}

M.get_current_line_diagnostics = function()
	-- 获取当前行的诊断信息
	local line_number = vim.fn.line(".") -- 获取当前光标所在的行号
	local diagnostics = vim.diagnostic.get(0, { lnum = line_number - 1 }) -- 获取当前行的诊断信息 (行号从0开始 所以要 -1)

	-- 如果该行有诊断信息，打印错误消息
	if #diagnostics > 0 then
		for _, diagnostic in ipairs(diagnostics) do
			vim.fn.setreg("+", diagnostic.message)
			-- 打印每个诊断信息的内容
			print(string.format("Diagnostic on line %d: %s", line_number, diagnostic.message))
		end
	else
		print("No diagnostics on this line.")
	end
end

-- 打开诊断信息
M.openDiagnostics = function()
	-- 直接提示
	vim.diagnostic.open_float({
		border = "rounded",
		focusable = true,
	})
	M.get_current_line_diagnostics()
end

return M
