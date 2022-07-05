-- 每个服务都有一个App的扩展
require("dysonet.init")
require("common.app")

local App = Extend("App")
function App:OnInit()
    xlogger.init()
end

function App:OnStart()
    xlogger.logf("client", "a=%d, b=%d", 100, 2000)
    xlogger.print("hello", "world")
end
