-- 每个服务都有一个App的扩展
require("common.app")

local App = Extend("App")
function App:OnInit()
    Cfg:Init("assets/config")
    Cfg:LoadCfg()
end

function App:OnStart()
    -- create
    self.actor:create("client", require("svr.m.api.client.init"))
    self.actor:create("cluster", require("svr.m.api.server.init"))
    self.actor:create("console", require("svr.m.api.gm.init"))
    self.actor:create("http", require("svr.m.api.http.init"))

    -- open
    self.actor:open("client")
    self.actor:open("console")
    self.actor:open("http")

    Cfg:InitCfg()
    -- xlogger.logf("client", "a=%d, b=%d", 100, 2000)
    -- xlogger.print("hello", "world")
    --xlogger.print(self, "你好")
    xlogger.print(string.trim("   testabab", "ab"))
    xlogger.print(string.tohex("123456789abcadadadandjadjhajdhjahdjahjdajkdkaioquwienapkmbka", true))
    xlogger.print(Cfg:Get("task", 1))
end
