local ApiGM = Class("ApiGM")
function ApiGM:__Init()
    require("svr.m.api.gm.sys")
    require("svr.m.api.gm.player")
end

return ApiGM
