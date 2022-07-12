require("svr.m.app")

local skynet = require "skynet"
skynet.init(function()
	skynet.error("Server init")
	App:Init(".m")
end)

skynet.start(function()
	skynet.error("Server start")
	App:Start()
	--skynet.exit()
end)
