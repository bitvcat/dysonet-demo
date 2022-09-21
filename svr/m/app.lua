-- 每个服务都有一个App的扩展
require("common.app")

local App = Extend("App")
function App:onInit()
    --require("LuaPanda").startServer("127.0.0.1",8818)

    Cfg:Init("assets/config")
    Cfg:loadCfg()

    -- init
    Client:Init(require("svr.m.api.client.init"))
    Cluster:Init(require("svr.m.api.server.init"))
    Console:Init(require("svr.m.api.gm.init"))
    Http:Init(require("svr.m.api.http.init"))
end

function App:onStart()
    -- open
    Console:open()
    Client:open(CONST.GATE_TCP | CONST.GATE_WS | CONST.GATE_WSS)
    Http:open(CONST.GATE_HTTP | CONST.GATE_HTTPS)

    Cfg:initCfg()

    -- test
    self:test()
end

function App:test()
    print("test print ----------->>")
    -- test logger.logf
    logger.logf("INFO", "client", "a=%d, b=%d", 100, 2000)

    -- test string lib
    logger.print(string.trim("   testabab", "ab"))
    logger.print(string.tohex("123456789abcadadadandjadjhajdhjahdjahjdajkdkaioquwienapkmbka", true))
    logger.print(string.tohex("abc", true))
    logger.print(string.tohex(string.pack(">s2","abc"), true))

    -- test cfg
    logger.print(Cfg:get("task", 1))
    logger.color("GREEN", Cfg:get("task", 2))

    -- test dysonet.xpcall
    --local ok, err = dysonet.xpcall(function() return 1/a end)
    --logger.print(ok, err)
    logger.print(_G.utf8)
end