return {
	{
		"Exafunction/windsurf.vim",
		event = "BufEnter",
	},
	-- Copilot 核心
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			suggestion = { enabled = true }, -- 关闭 inline 建议
	-- 			panel = { enabled = true }, -- 关闭面板
	-- 		})
	-- 	end,
	-- },
	-- -- Copilot -> nvim-cmp 桥接
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	dependencies = { "copilot.lua" },
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
}
