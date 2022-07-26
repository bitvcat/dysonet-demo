require("svr.m.app")

local skynet = dysonet.skynet
skynet.init(function()
	skynet.error("Server init")
	App:Init(".m")
end)

skynet.start(function()
	skynet.error("Server start")
	App:start()
	--skynet.exit()
end)
