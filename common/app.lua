-- app
require("common.actor.init")
local skynet = require("skynet")

local App = Class("App")
function App:__init()
    skynet.error("----- App init -----")
    self.actor = Actor:New()
    self.actor:start()
end

function App:getTcpGateConf()
    local gateConf = {
        watchdog = skynet.self(),
        maxclient = 1024,
    }
    return gateConf
end
