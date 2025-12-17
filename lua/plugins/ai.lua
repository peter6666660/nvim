return {
	{
		"Exafunction/windsurf.vim",
		event = "BufEnter",
	},
	-- -- INFO: Chart
	{
		"yetone/avante.nvim",
		-- build = vim.fn.has("win32") ~= 0
		-- 		and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		-- 	or "make",
		event = "VeryLazy",
		version = false,
		opts = {
			provider = "ollama",
			providers = {
				ollama = {
					-- Ollama 服务地址（完整带端口）
					endpoint = "http://192.168.0.14:11434",
					model = "qwen2.5-coder:14b",

					-- 可选：把这些放到 extra_request_body
					extra_request_body = {
						temperature = 0.2,
					},

					-- 如果需要工具执行，可能需要这些
					timeout = 60000, -- 60s
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	},
}
