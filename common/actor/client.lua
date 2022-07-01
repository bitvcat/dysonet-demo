--- client actor

local skynet = require "skynet"

local Client = Class("Client")
function Client:__ctor()
    self.links = {}
    self.closeCallback = nil
end

--- 消息派发处理
function Client:dispatch(session, source, cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    func(self, ...)
end

function Client:_sendToLink(fd, cmd, ...)
    local link = self:getLink(fd)
    if link then
        skynet.send(link.gateAddr, "lua", cmd, fd, ...)
    end
end

function Client:newLink(fd, addr, gateNode, gateAddr)
    local linkobj = {
        pid = 0,
        fd = assert(fd),
        addr = assert(addr),
        gateNode = assert(gateNode),
        gateAddr = assert(gateAddr),
    }
    return linkobj
end

function Client:delLink(fd)
    local link = self.links[fd]
    if link then
        self.links[fd] = nil
    end
    return link
end

function Client:closeLink(fd)
    self:_sendToLink(fd, "close")
    self:delLink(fd)
end

--- onXXX
function Client:onConnect(fd, addr, gateNode, gateAddr)
    local link = self:newLink(fd, addr, gateNode, gateAddr)
    self.links[fd] = link
end

function Client:onMessage(fd, opcode, args)
    if opcode == 0 then
        -- 纯文本消息
    else
        -- protobuf 消息
    end
end

function Client:onClose(fd, reason)
    local link = self:delLink(fd)
    if link then
        if self.closeCallback then
            self.closeCallback(link, reason)
        end
    end
end

--- 消息发送处理
function Client:send(fd, opname, args)
    self:_sendToLink(fd, "write", opname, args)
end
