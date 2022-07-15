-- 每个服务都有一个App的扩展
require("common.app")

local App = Extend("App")
function App:OnInit()
    Cfg:Init("assets/config")
    Cfg:LoadCfg()

    -- init
    Client:Init(require("svr.m.api.client.init"))
    Cluster:Init(require("svr.m.api.server.init"))
    Console:Init(require("svr.m.api.gm.init"))
    Http:Init(require("svr.m.api.http.init"))
end

function App:OnStart()
    -- open
    Client:Open()
    Console:Open()
    Http:Open()

    Cfg:InitCfg()
    -- xlogger.logf("client", "a=%d, b=%d", 100, 2000)
    -- xlogger.print("hello", "world")
    --xlogger.print(self, "你好")
    xlogger.print(string.trim("   testabab", "ab"))
    xlogger.print(string.tohex("123456789abcadadadandjadjhajdhjahdjahjdajkdkaioquwienapkmbka", true))
    xlogger.print(Cfg:Get("task", 1))
end
