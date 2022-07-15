-- app
require("dysonet.init")
require("common.actor.init")
require("common.cfg.cfg")
local skynet = require("skynet")

local App = Class("App")
function App:__Init(serviceName, ...)
    skynet.error("----- App Init -----")
    xlogger.init()

    self.nodes = require("etc.nodes")
    self.nodeName = skynet.getenv("name")
    self.serviceName = serviceName
    skynet.error("SERVICENAME", SERVICE_NAME)

    if self.OnInit then
        self:OnInit(...)
    end
end

function App:Start(...)
    skynet.error("----- App Start -----")
    skynet.dispatch("lua", function(...)
        self:Dispatch(...)
    end)

    if self.OnStart then
        self:OnStart(...)
    end
end

--- 消息派发处理
function App:Dispatch(session, source, typename, ...)
    local handler = _G[typename]
    if handler then
        if session ~= 0 then
            skynet.retpack(handler:Dispatch(session, source, ...))
        else
            handler:Dispatch(session, source, ...)
        end
    else
        skynet.error(string.format("op=dispatch,typename=%s not exist", typename))
    end
end

function App:LoadEnv()
    --local nodes = skynet.getenv("")
end
