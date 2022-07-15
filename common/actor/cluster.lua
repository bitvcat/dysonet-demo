--- cluster actor

local skynet = require "skynet"
local cluster = require "skynet.cluster"

local Cluster = Class("Cluster")
function Cluster:__init(apiobj)
    assert(type(apiobj) == "table")
    self.apiobj = apiobj
    self.apiobj:Init()

    self.nodes = {}
end

function Cluster:open()
    -- local addrs = {
    --     db = "127.0.0.1:2528",
    --     db2 = "127.0.0.1:2529",
    -- }
    -- cluster.reload(addrs)
    -- cluster.open("db")
    -- cluster.register("sdb")
end

--- 消息派发处理
function Cluster:dispatch(session, source, cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    return func(self, ...)
end

function Cluster:api(subcmd, ...)
    local handler = self.apiobj[subcmd]
    assert(handler, subcmd)
    return handler(self.apiobj, ...)
end

function Cluster:exec()

end

--- 消息发送处理
function Cluster:send(node, addr)
    cluster.call("db2", "@sdb", "GET", "b")
end
