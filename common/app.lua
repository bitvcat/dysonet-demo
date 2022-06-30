-- app
local skynet = require("skynet")

local App = Class("App")
function App:__init()
end

function App:getTcpGateConf()
    local gateConf = {
        watchdog = skynet.self(),
        maxclient = 1024,
    }
    return gateConf
end
