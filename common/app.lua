-- app
require("dysonet.init")
require("common.actor.init")
require("common.cfg.cfg")
local skynet = require("skynet")

local App = Class("App")
function App:__init(serviceName, ...)
    skynet.error("----- App Init -----")
    xlogger.init()

    self.nodes = require("etc.nodes")
    self.nodeName = skynet.getenv("name")
    self.serviceName = serviceName
    skynet.error("SERVICENAME", SERVICE_NAME)

    if self.onInit then
        self:onInit(...)
    end
end

function App:start(...)
    skynet.error("----- App Start -----")
    skynet.dispatch("lua", function(...)
        self:dispatch(...)
    end)

    if self.onStart then
        self:onStart(...)
    end
end

--- 消息派发处理
function App:dispatch(session, source, typename, ...)
    local handler = _G[typename]
    if handler then
        if session ~= 0 then
            skynet.retpack(handler:dispatch(session, source, ...))
        else
            handler:dispatch(session, source, ...)
        end
    else
        skynet.error(string.format("op=dispatch,typename=%s not exist", typename))
    end
end

function App:loadEnv()
    --local nodes = skynet.getenv("")
end
