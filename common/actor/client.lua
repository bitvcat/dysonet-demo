--- client actor
-- eg.:
--  skynet.send(addr, "lua", "Client", "onMessage", "C2S_Task_Finish", ...)

--[[!
    @file
    @brief Client actor 类源文件。
    @details 这里是详细描述。
]]


--! @class Client
--! @brief Client Actor 类
local Client = Class("Client")

--! @brief Client constructor
function Client:__init(apiobj)
    assert(type(apiobj) == "table")
    self.apiobj = apiobj
    self.apiobj:Init()

    self.links = {}
    self.closeCallback = nil
end

--! @brief 获取网关配置
--! @param string protocol 网关协议[tcp|ws|wss]
--! @return 网关服务名
--! @return 网关配置
--!
--! use as:
--!	\code{lua}
--!	TWibble = class()
--!	function TWibble.init(instance)
--!		self.instance = instance
--!		-- more stuff here
--!	end
--! \endcode
function Client:getGateConfig(protocol)
    local skynet = dysonet.skynet
    local gateConf = {
        port = tonumber(skynet.getenv(protocol.."_port")),
        slaveNum = tonumber(skynet.getenv("gate_slave_num")),
        watchdog = skynet.self(),
        protocol = protocol
    }
    local suffix = protocol == "wss" and "ws" or protocol
    return "gate_"..suffix, gateConf
end

function Client:_open(protocol)
    local skynet = dysonet.skynet
    local gateName, conf = self:getGateConfig(protocol)
    assert(gateName)

    local gate = assert(skynet.newservice(gateName))
    skynet.call(gate, "lua", "open", conf)
    return gate
end

function Client:open(flag)
    for mask, protocol in pairs(CONST.GATE) do
        if (flag & mask) == mask then
            self[protocol] = self:_open(protocol)
        end
    end
end

--- 消息派发处理
function Client:dispatch(session, source, cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    return func(self, ...)
end

function Client:_sendToLink(fd, cmd, ...)
    local link = self:getLink(fd)
    if link then
        dysonet.skynet.send(link.gateAddr, "lua", cmd, fd, ...)
    end
end

function Client:newLink(fd, addr, gateNode, gateAddr, protocol)
    local linkobj = {
        pid = 0,
        fd = assert(fd),
        addr = assert(addr),
        gateNode = assert(gateNode),
        gateAddr = assert(gateAddr),
        protocol = assert(protocol)
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
function Client:onConnect(fd, addr, gateNode, gateAddr, protocol)
    local link = self:newLink(fd, addr, gateNode, gateAddr, protocol)
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
function Client:send(fd, opname, args, session)
    if session > 0 then
        session = session | 0x80000000
    end
    self:_sendToLink(fd, "write", opname, args, session)
end
