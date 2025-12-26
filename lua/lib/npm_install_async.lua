local M = {}

-- 判断 npm 全局包是否存在
local function npm_global_pkg_exists(pkg)
	local npm_root = vim.fn.trim(vim.fn.system({ "npm", "root", "-g" }))
	if npm_root == "" then
		return false
	end
	local path = npm_root .. "/" .. pkg
	return vim.fn.isdirectory(path) == 1
end

local function npm_install_async(pkg)
	if npm_global_pkg_exists(pkg) then
		-- 已经存在则提示
		vim.notify("npm global package '" .. pkg .. "' already installed", vim.log.levels.INFO)
		return
	end

	if vim.fn.executable("npm") == 0 then
		vim.notify("npm 未安装，无法 global install: " .. pkg, vim.log.levels.ERROR)
		return
	end

	vim.notify("Installing global npm package: " .. pkg, vim.log.levels.INFO)
	vim.fn.jobstart({ "npm", "install", "-g", pkg }, {
		on_stdout = function(_, data)
			if data then
				print(table.concat(data, "\n"))
			end
		end,
		on_stderr = function(_, data)
			if data then
				print(table.concat(data, "\n"))
			end
		end,
		on_exit = function(_, code)
			if code == 0 then
				vim.notify("Installed " .. pkg .. " successfully", vim.log.levels.INFO)
			else
				vim.notify("Error installing " .. pkg, vim.log.levels.ERROR)
			end
		end,
	})
end

M.setup = function()
	local pkgs = {
		"@vue/typescript-plugin",
	}

	for _, p in ipairs(pkgs) do
		npm_install_async(p)
	end
end

return M
