local M = {}
local ns_id = vim.api.nvim_create_namespace("GitBlameVT")

M.ShowBlame = function()
	local line0 = vim.fn.line(".") - 1
	local file = vim.fn.expand("%")
	local ok, result = pcall(vim.fn.systemlist, string.format("git blame -L %d,%d %s", line0 + 1, line0 + 1, file))

	if not ok or #result == 0 then
		return
	end
	-- 提取作者和时间
	local author, date = string.match(result[1], "%(([%w%s%-%.]+)%s+(%d%d%d%d%-%d%d%-%d%d%s+[%d:]+)")
	if not author or not date then
		vim.notify("Failed to parse blame info", vim.log.levels.ERROR)
		return
	end

	local display = author .. " • " .. date

	-- 清掉旧的
	vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

	vim.api.nvim_buf_set_extmark(0, ns_id, line0, 0, {
		virt_text = { { display, "Comment" } },
		virt_text_pos = "eol",
	})
end

return M
