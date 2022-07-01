require("svr.m.dysonet")

local skynet = require "skynet"
skynet.init(function()
	skynet.error("Server init")
	App:Init()
end)

skynet.start(function()
	skynet.error("Server start")

	local debug_port = skynet.getenv("debug_port")
	if debug_port then
		skynet.newservice("debug_console", debug_port)
	end

	local tcp_gate = skynet.newservice("tcp")
	local gateConf = {
		port = 12345,
		slaveNum = tonumber(skynet.getenv("gate_slave_num")),
		watchdog = skynet.self()
	}
	skynet.call(tcp_gate, "lua", "open", gateConf)
	--skynet.exit()
end)
