-- 每个主服务都有一个App的扩展
require("common.app")

local App = Extend("App")

--! @brief 主服务初始化回调
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

--! @brief 主服务开始回调
function App:onStart()
    -- open
    Console:open()
    Client:open(CONST.GATE_TCP | CONST.GATE_WS | CONST.GATE_WSS)
    Http:open(CONST.GATE_HTTP | CONST.GATE_HTTPS)

    Cfg:initCfg()

    -- test
    self:test()
end

--! @brief 测试函数
function App:test()
    print("test print ----------->>")
    -- test logger.logf
    logger.logf("INFO", "client", "a=%d, b=%d", 100, 2000)

    -- test string lib
    logger.print(string.trim("   testabab", "ab"))
    logger.print(string.tohex("abc", true))
    logger.print(string.tohex(string.pack(">s2","123456789abcdefhijklmnopqrstuvwxyz"), true))

    -- test cfg
    logger.print(Cfg:get("task", 1))
    logger.color("GREEN", Cfg:get("task", 2))

    -- test dysonet.xpcall
    --local ok, err = dysonet.xpcall(function() return 1/a end)
    --logger.print(ok, err)
    logger.print(_G.utf8)
    logger.print(string.trim1([["abchelllo cat"]], '"abc'))
end

--! @class Base
--! @brief Base 类
local Base = Class("Base")
function Base:__init()
end

--! @brief base 测试函数
--! @param string a this is a value
--! @param string b this is b value
function Base:test(a, b)
end

--! @class Foo
--! @brief Foo 类
local Foo = Class("Foo", "Base")
function Foo:__init()
end

--! @class Bar
--! @brief Bar 类
local Bar = Class("Bar", "Base")
function Bar:__init()
end

--! @class Dog
--! @brief Dog 类
local Dog = class("Dog", Foo, "Bar")
function Dog:__init()
end