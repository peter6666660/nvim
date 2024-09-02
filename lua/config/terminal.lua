local Terminal = require("toggleterm.terminal").Terminal
local M = {}
M.float = Terminal:new({ hidden = true,  direction = "float" })

M.ToggleFloatTerminal = function()
	M.float:toggle()
end

return M
