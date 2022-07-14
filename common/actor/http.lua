--- http actor

local skynet = require "skynet"

local Http = Class("Http")
function Http:__ctor(apiobj)
    assert(type(apiobj) == "table")
    self.apiobj = apiobj
    self.apiobj:Init()
end

function Http:open()

end
