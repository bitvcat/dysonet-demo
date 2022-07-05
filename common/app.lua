-- app
require("common.actor.init")
local skynet = require("skynet")

local App = Class("App")
function App:__Init()
    skynet.error("----- App Init -----")
    self.actor = Actor:New()
    self.actor:start()

    if self.OnInit then
        self:OnInit()
    end
end

function App:Start()
    skynet.error("----- App Start -----")
    if self.OnStart then
        self:OnStart()
    end
end

function App:GetTcpGateConf()
    local gateConf = {
        watchdog = skynet.self(),
        maxclient = 1024,
    }
    return gateConf
end
