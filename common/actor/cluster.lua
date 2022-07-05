--- cluster actor

local skynet = require "skynet"
local cluster = require "skynet.cluster"

local Cluster = Class("Cluster")
function Cluster:__ctor()

end

function Cluster:open()

end

--- 消息派发处理
function Cluster:dispatch(session, source, cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    func(self, ...)
end
