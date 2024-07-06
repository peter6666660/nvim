return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("nvim-autopairs").setup({})
		-- 启用对 HTML 文件的自动闭合
    require('nvim-ts-autotag').setup()
	end,
}
