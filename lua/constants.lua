local M = {}

M.DEFAULT_CONFIG_PATH = vim.fn.stdpath("config") .. "/lua/config/machine_specific.lua"
M.DEFAULT_CONFIG_PATH_TEMPLATE = vim.fn.stdpath("config") .. "/default_config/_machine_specific_default.lua"

return M
