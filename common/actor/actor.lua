-- actor
--[[
消息处理流程：
1. 网关服务收到消息，先进行拆包处理；
2. 网关服务将数据包交给应用服务的 actor 模块进行处理；
    网关发送给应用服务的参数格式如下：
    skynet.send(actor_service, "lua", "client/cluster/internal/console", "cmd" ...)
--]]

local skynet = require("skynet")

local Actor = Class("Actor")
function Actor:__ctor()
    self.client = false --处理客户端消息
    self.cluster = false --处理集群消息
    self.internal = false --处理节点内部消息
    self.console = false --处理debug_console消息
    self.http = false --处理http消息
end

function Actor:start()
    skynet.dispatch("lua", function(...)
        self:dispatch(...)
    end)
end

function Actor:open(typename, api)
    local clsname = string.upper(string.sub(typename, 1, 1)) .. string.sub(typename, 2)
    local obj = _G[clsname]:New()
    self[typename] = obj
    obj:open(api)
end

--- 消息派发处理
function Actor:dispatch(session, source, typename, ...)
    local handler = self[typename]
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

--- 消息发送处理
function Actor:send(typename, ...)
    local handler = self[typename]
    if handler then
        handler:send(...)
    end
end
