local log = require("utils.log")

local function create_vendor_config(model, endpoint, disable_tools)
	return {
		-- __inherited_from = "openai",
		__inherited_from = "ollama",
		model = model,
		endpoint = endpoint,
		-- api_key_name = "",
		max_completion_tokens = 8192,
		-- request_body = {
		-- 	url = endpoint .. "/api/chat",
		-- },
		-- is_disable_stream = function()
		-- 	return false
		-- end,
		---@type fun(opts: AvanteProvider, code_opts: AvantePromptOptions): AvanteCurlOutput
		-- parse_curl_args = function(opts, code_opts)
		-- 	local openai = require("avante.providers.openai")
		--
		-- 	log.log_debug("----------code_opts.tools--------------")
		-- 	log.log_debug(vim.inspect(code_opts.tools))
		--
		-- 	local _disable_tools = disable_tools or false
		-- 	local serialized_tools = nil
		-- 	if not _disable_tools and code_opts.tools and #code_opts.tools > 0 then
		-- 		serialized_tools = {}
		-- 		for _, tool in ipairs(code_opts.tools) do
		-- 			table.insert(serialized_tools, openai:transform_tool(tool))
		-- 		end
		-- 	end
		--
		-- 	---@type AvanteCurlOutput
		-- 	local output = {
		-- 		url = endpoint .. "/api/chat",
		-- 		headers = {
		-- 			["Content-Type"] = "application/json",
		-- 			["Accept"] = "application/json",
		-- 		},
		-- 		body = {
		-- 			model = model,
		-- 			stream = true,
		-- 			messages = openai:parse_messages(code_opts),
		-- 			system = code_opts.system_prompt,
		-- 			keep_alive = "5m",
		-- 			tools = serialized_tools,
		-- 		},
		-- 	}
		-- 	-- log.log_debug("----------output--------------")
		-- 	-- log.log_debug(vim.inspect(serialized_tools))
		-- 	return output
		-- end,
		-- parse_response = nil,
		---@type fun(data: string, handler_opts: AvanteHandlerOptions): nil
		-- parse_stream_data = function(data, handler_opts)
		-- 	log.log_debug("------------data------------")
		-- 	log.log_debug(vim.inspect(data))
		-- 	log.log_debug("------------handler_opts------------")
		-- 	log.log_debug(vim.inspect(handler_opts))
		--
		-- 	-- local ok, json_data = pcall(vim.json.decode, data)
		-- 	-- if not ok or not json_data then
		-- 	-- 	-- Add debug logging
		-- 	-- 	return
		-- 	-- end
		-- 	--
		-- 	-- if json_data.message and json_data.message.content then
		-- 	-- 	local content = json_data.message.content
		-- 	-- 	if content and content ~= "" then
		-- 	-- 		handler_opts.on_chunk(content)
		-- 	-- 	end
		-- 	-- end
		-- 	--
		-- 	-- if json_data.done then
		-- 	-- 	handler_opts.on_stop({ reason = "complete" })
		-- 	-- 	return
		-- 	-- end
		-- end,
	}
end

local endpointBase = "http://192.168.0.201:11434"

local vendors = {
	codellama_34b = create_vendor_config("codellama:34b", endpointBase),
	qwen25_code_tools_14b = create_vendor_config("hhao/qwen2.5-coder-tools:14b", endpointBase),
	qwen25_code_14b = create_vendor_config("qwen2.5-coder:14b", endpointBase),
	-- qwen25_code_14b = create_vendor_config("hermes3:8b-llama3.1-q8_0", endpointBase),
	qwen25_32b = create_vendor_config("qwen2.5:32b", endpointBase),
	llama3groqtooluse = create_vendor_config("llama3-groq-tool-use", endpointBase),
	qwq = create_vendor_config("qwq:latest", endpointBase),
	solar = create_vendor_config("solar", endpointBase),
	yicoder9b = create_vendor_config("yi-coder:9b", endpointBase),
}
local current_model = "qwen25_code_14b"

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
				-- port = 37373,
				config = vim.fn.expand("~/.config/nvim/mcpServers.json"),
				auto_approve = true,
				extensions = {
					avante = {
						make_slash_commands = true, -- make /slash commands from MCP server prompts
					},
				},
				shutdown_delay = 0, -- Wait 0ms before shutting down server after last client exits
				log = {
					level = vim.log.levels.WARN,
					to_file = false,
					file_path = nil,
					prefix = "MCPHub",
				},
			})
		end,
	},
	-- INFO: Chart
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- 永远不要将此值设置为 "*"！永远不要！
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
		config = function()
			require("avante").setup({
				provider = current_model, -- planning 阶段用大模型
				cursor_applying_provider = current_model, -- applying 阶段用小模型
				behaviour = {
					enable_claude_text_editor_tool_mode = true,
					enable_cursor_planning_mode = true, -- 启用 Cursor 风格的 planning 模式！
					auto_suggestions = true,
				},
				vendors = vendors,
				-- vendors = {
				-- 	qwen25_code_14b = {
				-- 		model = "qwen2.5-coder:14b",
				-- 		endpoint = endpointBase,
				-- 		max_completion_tokens = 8192,
				-- 		is_disable_stream = function()
				-- 			return false
				-- 		end,
				-- 		---@type fun(opts: AvanteProvider, code_opts: AvantePromptOptions): AvanteCurlOutput
				-- 		parse_curl_args = function(opts, code_opts)
				-- 			local openai = require("avante.providers.openai")
				--
				-- 			local _disable_tools = false
				-- 			local serialized_tools = nil
				-- 			if not _disable_tools and code_opts.tools and #code_opts.tools > 0 then
				-- 				serialized_tools = {}
				-- 				for _, tool in ipairs(code_opts.tools) do
				-- 					table.insert(serialized_tools, openai:transform_tool(tool))
				-- 				end
				-- 			end
				--
				-- 			---@type AvanteCurlOutput
				-- 			local output = {
				-- 				url = endpointBase .. "/api/chat",
				-- 				headers = {
				-- 					["Content-Type"] = "application/json",
				-- 					["Accept"] = "application/json",
				-- 				},
				-- 				body = {
				-- 					model = "qwen2.5-coder:14b",
				-- 					stream = true,
				-- 					messages = openai:parse_messages(code_opts),
				-- 					system = code_opts.system_prompt,
				-- 					keep_alive = "5m",
				-- 					tools = serialized_tools,
				-- 				},
				-- 			}
				-- 			log.log_debug("----------output--------------")
				-- 			log.log_debug(vim.inspect(output))
				-- 			return output
				-- 		end,
				-- 		parse_stream_data = function(data, handler_opts)
				-- 			log.log_debug("------------data------------")
				-- 			log.log_debug(vim.inspect(data))
				-- 			log.log_debug("------------handler_opts------------")
				-- 			log.log_debug(vim.inspect(handler_opts))
				--
				-- 			-- local ok, json_data = pcall(vim.json.decode, data)
				-- 			-- if not ok or not json_data then
				-- 			-- 	-- Add debug logging
				-- 			-- 	return
				-- 			-- end
				-- 			--
				-- 			-- if json_data.message and json_data.message.content then
				-- 			-- 	local content = json_data.message.content
				-- 			-- 	if content and content ~= "" then
				-- 			-- 		handler_opts.on_chunk(content)
				-- 			-- 	end
				-- 			-- end
				-- 			--
				-- 			-- if json_data.done then
				-- 			-- 	handler_opts.on_stop({ reason = "complete" })
				-- 			-- 	return
				-- 			-- end
				-- 		end,
				-- 	},
				-- },
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
				disabled_tools = {
					"list_files",
					"search_files",
					"read_file",
					"create_file",
					"rename_file",
					"delete_file",
					"create_dir",
					"rename_dir",
					"delete_dir",
					"bash",
				},
			})
		end,
	},
}
