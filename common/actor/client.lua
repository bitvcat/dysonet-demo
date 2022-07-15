--- client actor
-- eg.:
--  skynet.send(addr, "lua", "Client", "onMessage", "C2S_Task_Finish", ...)

local skynet = require "skynet"

local Client = Class("Client")
function Client:__Init(apiobj)
    assert(type(apiobj) == "table")
    self.apiobj = apiobj
    self.apiobj:Init()

    self.tcpGate = false
    self.links = {}
    self.closeCallback = nil
end

function Client:Open()
    -- gate service
    self.tcpGate = assert(skynet.newservice("gate_tcp"))

    -- open gate
    local gateConf = {
        port = tonumber(skynet.getenv("tcp_port")),
        slaveNum = tonumber(skynet.getenv("gate_slave_num")),
        watchdog = skynet.self()
    }
    skynet.call(self.tcpGate, "lua", "open", gateConf)
end

--- 消息派发处理
function Client:Dispatch(session, source, cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    return func(self, ...)
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

function Client:onMessage(fd, opname, args, session)
    local link = self:getLink(fd)
    if link then
        return
    end

    assert(session >= 0, session)
    local ok = self.apiobj:judgLink(link, opname, args)
    if not ok then
        -- logger
        -- TODO
        return
    end
    local opfunc = self.apiobj[opname]
    if opfunc then
        opfunc(self.apiobj, link, args, session)
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
function Client:Send(fd, opname, args, session)
    if session > 0 then
        session = session | 0x80000000
    end
    self:_sendToLink(fd, "write", opname, args, session)
end
