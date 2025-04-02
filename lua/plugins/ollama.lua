local Ollama = {
	model = "hhao/qwen2.5-coder-tools:14b",
	host = "http://192.168.0.201:11434", -- 如果用 Ollama，本地 AI
}

-- return {
-- 	"nomnivore/ollama.nvim",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 	},
--
-- 	-- All the user commands added by the plugin
-- 	cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
--
-- 	keys = {
-- 		-- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
-- 		{
-- 			"<leader>oo",
-- 			":<c-u>lua require('ollama').prompt()<cr>",
-- 			desc = "ollama prompt",
-- 			mode = { "n", "v" },
-- 		},
--
-- 		-- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
-- 		{
-- 			"<leader>oG",
-- 			":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
-- 			desc = "ollama Generate Code",
-- 			mode = { "n", "v" },
-- 		},
-- 	},
--
-- 	---@type Ollama.Config
-- 	opts = {
-- 		url = "http://192.168.0.201:11434",
-- 		model = "codellama:34b",
-- 	},
-- }
return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- 永远不要将此值设置为 "*"！永远不要！
	opts = {
		provider = "ollama",
		ollama = {
			model = Ollama.model,
			endpoint = Ollama.host,
		},
	},
	-- 如果您想从源代码构建，请执行 `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- 对于 Windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- 以下依赖项是可选的，
		"echasnovski/mini.pick", -- 用于文件选择器提供者 mini.pick
		"nvim-telescope/telescope.nvim", -- 用于文件选择器提供者 telescope
		"hrsh7th/nvim-cmp", -- avante 命令和提及的自动完成
		"ibhagwan/fzf-lua", -- 用于文件选择器提供者 fzf
		"nvim-tree/nvim-web-devicons", -- 或 echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- 用于 providers='copilot'
		{
			-- 支持图像粘贴
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- 推荐设置
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- Windows 用户必需
					use_absolute_path = true,
				},
			},
		},
		{
			-- 如果您有 lazy=true，请确保正确设置
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
