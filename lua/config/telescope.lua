-- 在 telescope.nvim 中，builtin 模块是一个核心模块，它包含了多个内置的功能，旨在为你提供常见的查找操作，如文件查找、文本查找、缓冲区浏览、LSP 诊断等。通过 telescope.builtin，你可以调用这些功能，而不需要手动配置复杂的操作。

local M = {}

M.openDiagnostics = function()
	require("telescope.builtin").diagnostics({
		bufnr = 0, -- 当前缓冲区
	})
end

return M
