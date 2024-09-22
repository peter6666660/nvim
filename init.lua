local function loadLazy()
	require("config.lazy")
end

-- -- 默认配置
-- require("config.defaults").setup(loadLazy)

local co_default_config = require("config.defaults").setup()

local function wait_for_load()
	while coroutine.status(co_default_config) ~= "dead" do
		vim.wait(100)
	end
end

-- 等待配置文件加载成功
wait_for_load()

-- 加载lazy
loadLazy()
