-- 每个服务都有一个App的扩展
require("common.app")

local App = Extend("App")
function App:onInit()
    require("LuaPanda").start("127.0.0.1",8818)
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
    -- xlogger.logf("client", "a=%d, b=%d", 100, 2000)
    -- xlogger.print("hello", "world")
    --xlogger.print(self, "你好")
    xlogger.print(string.trim("   testabab", "ab"))
    xlogger.print(string.tohex("123456789abcadadadandjadjhajdhjahdjahjdajkdkaioquwienapkmbka", true))
    xlogger.print(Cfg:get("task", 1))
    xlogger.print(string.tohex("abc", true))
    xlogger.print(string.tohex(string.pack(">s2","abc"), true))
end
