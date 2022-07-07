--- http actor

local skynet = require "skynet"

local Http = Class("Http")
function Http:__ctor()
    self.apiobj = nil
end

function Http:open(apiobj)
    assert(type(apiobj) == "table")
    self.apiobj = apiobj
    self.apiobj:Init()
end
