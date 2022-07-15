-- internal actor
-- eg.:
--  skynet.send(addr, "lua", "Internal, "api", "ping", ...)
--  skynet.send(addr, "lua", "Internal, "exec", ...)

local skynet = require "skynet"

local Internal = Class("Internal")
function Internal:__init(apiobj)
    assert(type(apiobj) == "table")
    self.apiobj = apiobj
    self.apiobj:Init()
end

function Internal:open(apiobj)
end

function Internal:dispatch(cmd, ...)
    local func = self[cmd]
    assert(func, cmd)
    return func(...)
end

function Internal:api(subcmd, ...)
    local handler = self.apiobj[subcmd]
    assert(handler, subcmd)
    return handler(self.apiobj, ...)
end

function Internal:exec(cmdstr)
end
