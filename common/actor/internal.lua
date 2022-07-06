-- internal actor
-- eg.:
--  skynet.send(addr, "lua", "internal, "api", "ping", ...)
--  skynet.send(addr, "lua", "internal, "exec", ...)

local skynet = require "skynet"

local Internal = Class("Internal")
function Internal:__ctor()
    self.api = nil
end

function Internal:open(api)
    assert(type(api) == "table")
    self.api = api
    self.api:Init()
end

function Internal:dispatch(cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    return func(...)
end

function Internal:api(subcmd, ...)
    local handler = self.api[subcmd]
    assert(handler, subcmd)
    return handler(...)
end

function Internal:exec(cmdstr)
end
