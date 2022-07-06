--- http actor

local skynet = require "skynet"

local Http = Class("Http")
function Http:__ctor()
    self.api = nil
end

function Http:open(api)
    assert(type(api) == "table")
    self.api = api
    self.api:Init()
end
