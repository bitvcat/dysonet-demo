-- app
require("dysonet.init")
require("common.const.init")
require("common.actor.init")
require("common.cfg.cfg")

local App = Class("App")
function App:__init(serviceName, ...)
    local skynet = dysonet.skynet
    skynet.error("----- App Init -----")
    logger.init()

    self.nodeName = skynet.getenv("name")
    self.serviceName = serviceName
    skynet.error("SERVICENAME", SERVICE_NAME)
    self.dbs = {}

    if self.onInit then
        self:onInit(...)
    end
end

function App:start(...)
    local skynet = dysonet.skynet
    skynet.error("----- App Start -----")
    skynet.dispatch("lua", function(...)
        self:dispatch(...)
    end)

    if self.onStart then
        self:onStart(...)
    end
end

--- 消息派发处理
function App:dispatch(session, source, typename, ...)
    local skynet = dysonet.skynet
    local handler = _G[typename]
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

function App:initDB()
    local mongoConf = {
        host = host,
        port = port,
		username = username,
        password = password,
		authdb = db_name,
    }
    local mongoClient = dysonet.mongo.client()
end

function App:getDB()

end