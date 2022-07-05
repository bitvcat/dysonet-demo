-- app
require("common.actor.init")
local skynet = require("skynet")

local App = Class("App")
function App:__Init(serviceName, ...)
    skynet.error("----- App Init -----")
    self.nodes = require("etc.nodes")
    self.actor = Actor:New()
    self.actor:start()
    self.nodeName = skynet.getenv("name")
    self.serviceName = serviceName
    skynet.error("SERVICENAME", SERVICE_NAME)

    if self.OnInit then
        self:OnInit(...)
    end
end

function App:Start(...)
    skynet.error("----- App Start -----")
    if self.OnStart then
        self:OnStart(...)
    end
end

function App:LoadEnv()
    --local nodes = skynet.getenv("")
end
