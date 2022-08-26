-- 每个服务都有一个App的扩展
require("common.app")

local App = Extend("App")
function App:onInit()
    require("LuaPanda").startServer("127.0.0.1",8818)

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
    Client:open()
    Console:open()
    Http:open()

    Cfg:initCfg()

    -- test
    self:test()
end

function App:test()
    -- test xlogger.logf
    xlogger.logf("INFO", "client", "a=%d, b=%d", 100, 2000)

    -- test string lib
    xlogger.print(string.trim("   testabab", "ab"))
    xlogger.print(string.tohex("123456789abcadadadandjadjhajdhjahdjahjdajkdkaioquwienapkmbka", true))
    xlogger.print(string.tohex("abc", true))
    xlogger.print(string.tohex(string.pack(">s2","abc"), true))

    -- test cfg
    xlogger.print(Cfg:get("task", 1))

    -- test dysonet.xpcall
    --local ok, err = dysonet.xpcall(function() return 1/a end)
    --xlogger.print(ok, err)
end