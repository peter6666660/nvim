local function create_vendor_config(model, endpoint)
	return {
		__inherited_from = "ollama",
		model = model,
		endpoint = endpoint,
		max_completion_tokens = 8192,
	}
end

local endpointBase = "http://192.168.0.201:11434"
local vendors = {
	codellama_34b = create_vendor_config("codellama:34b", endpointBase),
	qwen25_code_tools_14b = create_vendor_config("hhao/qwen2.5-coder-tools:14b", endpointBase),
	qwen25_coder_tools_32b = create_vendor_config("hhao/qwen2.5-coder-tools:32b", endpointBase),
	solar = create_vendor_config("solar", endpointBase),
	yicoder9b = create_vendor_config("yi-coder:9b", endpointBase),
}

return {
	-- INFO: MCP
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
		config = function()
			require("mcphub").setup({
				port = 3109,
				config = vim.fn.expand("~/.config/nvim/mcpServers.json"),
				extensions = {
					avante = {
						make_slash_commands = true, -- make /slash commands from MCP server prompts
					},
				},
				on_ready = function() -- function (hub)
				end,
			})
		end,
	},
	-- INFO: Chart
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- 永远不要将此值设置为 "*"！永远不要！
		opts = {
			provider = "qwen25_code_tools_14b", -- planning 阶段用大模型
			cursor_applying_provider = "qwen25_code_tools_14b", -- applying 阶段用小模型
			behaviour = {
				enable_cursor_planning_mode = true, -- 启用 Cursor 风格的 planning 模式！
				auto_suggestions = true,
			},
			vendors = vendors,
			system_prompt = function()
				local hub = require("mcphub").get_hub_instance()
				if hub and hub:is_ready() then
					return hub:get_active_servers_prompt()
				else
					return "Default system prompt."
				end
			end,
			custom_tools = function()
				return {
					require("mcphub.extensions.avante").mcp_tool(),
				}
			end,
			prompt_opts = {
				on_tool_call = function(call)
					local ok = vim.fn.confirm(string.format("执行 %s 工具？", call.name), "&确认\n&取消") == 1
					return ok
				end,
			},
		},

		build = "make",

		dependencies = {
			"ravitemer/mcphub.nvim",
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",

			"echasnovski/mini.pick", -- 用于文件选择器提供者 mini.pick
			"nvim-telescope/telescope.nvim", -- 用于文件选择器提供者 telescope
			"hrsh7th/nvim-cmp", -- avante 命令和提及的自动完成
			"ibhagwan/fzf-lua", -- 用于文件选择器提供者 fzf
			"nvim-tree/nvim-web-devicons", -- 或 echasnovski/mini.icons
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
	},
}
