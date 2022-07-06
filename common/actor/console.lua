--- console actor

local skynet = require "skynet"

local Console = Class("Console")
function Console:__ctor()
    self.addr = false
end

function Console:open(api)
    assert(type(api) == "table")
    self.api = api
    self.api:Init()

    local debug_port = skynet.getenv("debug_port")
    if debug_port then
        self.addr = assert(skynet.newservice("debug_console", debug_port))
    end
end

--- 消息派发处理
function Console:dispatch(session, source, cmdline)
end
