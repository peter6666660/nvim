--  快捷键管理插件

-- 复制到剪切板
vim.api.nvim_set_keymap("v", "y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "p", '"+p', { noremap = true, silent = true })

-- 快速文档中跳转hop插件
vim.api.nvim_set_keymap("n", "s", ":lua require'hop'.hint_words()<CR>", { noremap = true, silent = true })

--普通模式下的快捷键
local nMappings = {
	["<leader>"] = {
		e = { ":NvimTreeToggle <CR>", "切换目录" },
		q = { ":q <CR>", "关闭文件" },
		w = { ":w <CR>", "保存文件" },
		b = {
			name = "Tab",
			l = { ":BufferLineCloseLeft <CR>", "关闭左边的tab" },
			r = { ":BufferLineCloseRight <CR>", "关闭左边的tab" },
			d = { ":bd <CR>", "关闭当前的tab" },
		},
		f = {
			name = "搜索文件",
			f = { ":Telescope find_files<CR>", "查文件" },
			["/"] = { ":Telescope live_grep<CR>", "查内容" },
			h = { ":Telescope help_tags<CR>", "查文档" },
			r = { ":Telescope oldfiles<CR>", "最近打开的文件" },
		},
		c = {
			name = "代码相关",
			f = { ":Neoformat <CR>", "格式化代码" },
		},
	},
}

-- 编辑模式
local iMappings = {
	["jk"] = { "<ESC>", "退出文件编辑" },
}

local setConfig = function(wk)
	wk.setup()
	wk.register({
		-- 分屏
		["<C-h>"] = { "<C-w>h", "切换到左分屏" },
		["<C-l>"] = { "<C-w>l", "切换到右分屏" },
		["<C-j>"] = { "<C-w>j", "切换到上分屏" },
		["<C-k>"] = { "<C-w>k", "切换到下分屏" },

		-- tab
		-- bufferline.nvim 主要用于美化和管理 Neovim 窗口中的缓冲区标签，它不直接控制缓冲区的打开和关闭。
		-- Neovim 的缓冲区是通过 :bd、:bw、:bn 和 :bp 等命令进行管理的。
		["<Tab>"] = { ":bn <CR>", "切换到下一个tab" },
		["<S-Tab>"] = { ":bp <CR>", "切换到上一个tab" },
	})

	wk.register(nMappings, {
		mode = "n",
		silent = true,
		noremap = true,
	})
	wk.register(iMappings, {
		mode = "i",
		silent = true,
		noremap = true,
	})
end

return {
	-- I have a separate config.mappings file where I require which-key.
	-- With lazy the plugin will be automatically loaded when it is required somewhere
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			local wk = require("which-key")
			setConfig(wk)
		end,
	},
}
