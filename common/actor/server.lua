--- cluster actor
--  skynet.send(addr, "lua", "Server, "api", "ping", ...)
--  skynet.send(addr, "lua", "Server, "exec", ...)
--[[!
    @file
    @brief Cluster actor 类源文件。
]]


--! @class Server
--! @brief Server Actor 类
local Server = Single("Server")
function Server:__init(apiobj)
    assert(type(apiobj) == "table")
    self.apiobj = apiobj
    self.apiobj:Init()

    self.nodes = {}
end

function Server:open()
    local cluster = dysonet.cluster
    -- local addrs = {
    --     db = "127.0.0.1:2528",
    --     db2 = "127.0.0.1:2529",
    -- }
    -- cluster.reload(addrs)
    -- cluster.open("db")
    -- cluster.register("sdb")
end

--- 消息派发处理
function Server:dispatch(session, source, cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    return func(self, ...)
end

function Server:api(subcmd, ...)
    local handler = self.apiobj[subcmd]
    assert(handler, subcmd)
    return handler(self.apiobj, ...)
end

function Server:exec()

end

--- 消息发送处理
function Server:send(node, addr)
    cluster.call("db2", "@sdb", "GET", "b")
end
