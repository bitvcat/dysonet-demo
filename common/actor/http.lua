--- http actor

local Http = Class("Http")
function Http:__init(apiobj)
    assert(type(apiobj) == "table")
    self.apiobj = apiobj
    self.apiobj:Init()
end

function Http:_open(protocol)
    assert(protocol=="http" or protocol=="https", protocol)
    local skynet = dysonet.skynet
    local gate = assert(skynet.newservice("gate_http"))
    local gateConf = {
        port = tonumber(skynet.getenv(protocol.."_port")),
        slaveNum = tonumber(skynet.getenv("gate_slave_num")),
        watchdog = skynet.self(),
        protocol = protocol
    }
    skynet.call(gate, "lua", "open", gateConf)
    return gate
end

function Http:open(flag)
    for mask, protocol in pairs(CONST.GATE) do
        if (flag & mask) == mask then
            self[protocol] = self:_open(protocol)
        end
    end
end

--- 消息派发处理
function Http:dispatch(session, source, cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    return func(self, ...)
end

function Http:onMessage(linkobj, path, method, query, header, body)
    logger.print(linkobj, path, method, query, header, body)
    local mod = self.apiobj[path]
    local func = mod and mod[method]
    if not func then
        return self:response(linkobj, 501)
    else
        local resp = func(linkobj, query, body)
        return self:response(linkobj, 200, resp)
    end
end

function Http:response(linkobj, code, body, header)
    header = header or {}
    header["content-type"] = "application/json;charset=utf-8"
    if body and type(body) == "table" then
        body = dysonet.cjson.encode(body)
    end
    return code, body, header
end
