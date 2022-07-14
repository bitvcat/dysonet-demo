--- http actor

local skynet = require "skynet"

local Http = Class("Http")
function Http:__ctor(apiobj)
    assert(type(apiobj) == "table")
    self.apiobj = apiobj
    self.apiobj:Init()

    self.httpGate = false
end

function Http:open()
    self.httpGate = assert(skynet.newservice("gate_http"))

    -- open http
    local gateConf = {
        port = tonumber(skynet.getenv("http_port")),
        slaveNum = tonumber(skynet.getenv("gate_slave_num")),
        protocol = "http",
        watchdog = skynet.self()
    }
    skynet.call(self.httpGate, "lua", "open", gateConf)
end

--- 消息派发处理
function Http:dispatch(session, source, cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    return func(self, ...)
end

function Http:onMessage(url, method, request)

end
