local Ollama = {
	model = "hhao/qwen2.5-coder-tools:14b",
	host = "http://192.168.0.201:11434", -- 如果用 Ollama，本地 AI
}

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

	build = "make",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",

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

				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},

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
