--  快捷键管理插件

-- 复制到剪切板
vim.api.nvim_set_keymap("v", "d", '"+d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "x", '"+x', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "p", '"+p', { noremap = true, silent = true })

-- 快速文档中跳转hop插件
vim.api.nvim_set_keymap("n", "s", ":lua require'hop'.hint_words()<CR>", { noremap = true, silent = true })

--普通模式下的快捷键
local nMappings = {
  { "<leader>b", group = "Tab", remap = false },
  { "<leader>bd", ":bd <CR>", desc = "关闭当前的tab", remap = false },
  { "<leader>bl", ":BufferLineCloseLeft <CR>", desc = "关闭左边的tab", remap = false },
  { "<leader>br", ":BufferLineCloseRight <CR>", desc = "关闭左边的tab", remap = false },

  { "<leader>c", group = "代码相关", remap = false },
  { "<leader>cf", ":Neoformat <CR>", desc = "格式化代码", remap = false },

  { "<leader>e", ":NvimTreeToggle <CR>", desc = "切换目录", remap = false },

  { "<leader>f", group = "搜索文件", remap = false },
  { "<leader>ff", ":Telescope find_files<CR>", desc = "查文件", remap = false },
  { "<leader>fg", ":Telescope live_grep<CR>", desc = "查内容", remap = false },
  { "<leader>fh", ":Telescope help_tags<CR>", desc = "查文档", remap = false },
  { "<leader>fr", ":Telescope oldfiles<CR>", desc = "最近打开的文件", remap = false },

  { "<leader>g", group = "Git", remap = false },
  { "<leader>gg", ":LazyGit <CR>", desc = "lazyGit", remap = false },

  { "<leader>q", ":q <CR>", desc = "关闭文件", remap = false },

  { "<leader>w", ":w <CR>", desc = "保存文件", remap = false },
}


local iMappings = {
  -- mode == i 编辑时触发
  {"jk", "<ESC>",desc="退出文件编辑", mode="i" }
}

local setConfig = function(wk)
	wk.setup()
	wk.add({
		-- 分屏切换
    {"<C-h>", "<C-w>h", desc="切换到左分屏"},
    {"<C-l>", "<C-w>l", desc="切换到右分屏"},
    {"<C-j>", "<C-w>j", desc="切换到上分屏"},
    {"<C-k>", "<C-w>k", desc="切换到下分屏"},

		-- tab
		-- bufferline.nvim 主要用于美化和管理 Neovim 窗口中的缓冲区标签，它不直接控制缓冲区的打开和关闭。
		-- Neovim 的缓冲区是通过 :bd、:bw、:bn 和 :bp 等命令进行管理的。
    {"<Tab>", ":bn <CR>", desc="切换到下一个tab"},
    {"<S-Tab>", ":bp <CR>", desc="切换到上一个tab"},
	})
	wk.add(nMappings)
	wk.add(iMappings)
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
