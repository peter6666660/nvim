-- 检查 Neovim 版本是否至少为 x.xx.x
local function check_minimum_version(major, minor, patch)
    local version = vim.version()
    if version.major < major or (version.major == major and version.minor < minor) or (version.major == major and version.minor == minor and version.patch < patch) then
        vim.api.nvim_err_writeln("Neovim version " .. major .. "." .. minor .. "." .. patch .. " or higher is required!")
        vim.cmd("quit")
    end
end

-- 设定最低版本为 0.10.1
check_minimum_version(0, 10, 1)

require("config.lazy")

