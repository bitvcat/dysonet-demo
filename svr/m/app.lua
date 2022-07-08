-- 每个服务都有一个App的扩展
require("common.app")

local App = Extend("App")
function App:OnInit()
end

function App:OnStart()
    self.actor:open("client", require("svr.m.api.client.init"))
    self.actor:open("cluster", require("svr.m.api.server.init"))
    self.actor:open("console", require("svr.m.api.gm.init"))

    -- xlogger.logf("client", "a=%d, b=%d", 100, 2000)
    -- xlogger.print("hello", "world")
    --xlogger.print(self, "你好")
end
