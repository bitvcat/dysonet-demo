--- http actor

local Http = Class("Http")
Http.FLAG_HTTP  = 0x01
Http.FLAG_HTTPS = 0X02

function Http:__init(apiobj)
    assert(type(apiobj) == "table")
    self.apiobj = apiobj
    self.apiobj:Init()

    self.httpGate = false       -- http gate
    self.httpsGate = false      -- https gate
end

function Http:open(flag)
    if (flag & Http.FLAG_HTTP) == Http.FLAG_HTTP then
        self:openHttp()
    end

    if (flag & Http.FLAG_HTTPS) == Http.FLAG_HTTPS then
        self:openHttps()
    end
end

function Http:openHttp()
    local skynet = dysonet.skynet
    self.httpGate = assert(skynet.newservice("gate_http"))

    -- open http
    local gateConf = {
        port = tonumber(skynet.getenv("http_port")),
        slaveNum = tonumber(skynet.getenv("gate_slave_num")),
        watchdog = skynet.self()
    }
    skynet.call(self.httpGate, "lua", "open", gateConf)
end

function Http:openHttps()
    local skynet = dysonet.skynet
    self.httpsGate = assert(skynet.newservice("gate_https"))

    -- open http
    local gateConf = {
        port = tonumber(skynet.getenv("https_port")),
        slaveNum = tonumber(skynet.getenv("gate_slave_num")),
        watchdog = skynet.self(),
        certfile = skynet.getenv("certfile"),
        keyfile = skynet.getenv("keyfile"),
    }
    skynet.call(self.httpsGate, "lua", "open", gateConf)
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
