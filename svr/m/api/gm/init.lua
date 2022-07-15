local ApiGM = Class("ApiGM")
function ApiGM:__init()
    require("svr.m.api.gm.sys")
    require("svr.m.api.gm.player")
end

return ApiGM
