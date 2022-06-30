--- client actor

local Client = Class("Client")
function Client:__ctor()
    self.links = {}
end

--- 消息派发处理
function Client:dispatch(session, source, cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    func(self, ...)
end

function Client:onConnect(fd, addr, gateNode, gateAddr)
end

function Client:onMessage(fd, opcode, args)
end

--- 消息发送处理
function Client:send()
end
