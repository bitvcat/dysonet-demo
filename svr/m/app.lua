-- 每个服务都有一个App的扩展
require("dysonet.init")
require("common.app")

local App = Extend("App")
function App:OnInit()
    xlogger.init()
end

function App:OnStart()
    self.actor:open("client", require("svr.m.api.client.init"))
    self.actor:open("cluster", require("svr.m.api.server.init"))

    xlogger.logf("client", "a=%d, b=%d", 100, 2000)
    xlogger.print("hello", "world")
    xlogger.print(self, "你号")
end
