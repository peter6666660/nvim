local M = {}

local function escape_lua_pattern(s)
	return s:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
end

-- 检查 npm 全局包是否已安装
local function npm_check(pkg)
	local cmd = "npm list -g --depth=0 " .. pkg
	local handle = io.popen(cmd)
	local output = handle:read("*a")
	handle:close()
	local pattern = escape_lua_pattern(pkg)

	if output:match(pattern) then
		vim.health.ok(string.format("npm package '%s' is installed", pkg))
	else
		vim.health.info(string.format("npm package '%s' is not found", pkg))
		if vim.fn.executable("npm") == 1 then
			vim.health.warn(
				string.format("You can install it globally with: npm install -g %s", pkg),
				{ "Run: npm install -g " .. pkg }
			)
		else
			vim.health.error("npm executable not found in PATH", {
				"Install Node.js/npm",
				"Ensure npm is in your PATH",
			})
		end
	end
end

function M.check()
	vim.health.start("Checking npm global packages")

	-- 在这里添加你要检查的包
	npm_check("@vue/typescript-plugin")
end

return M
