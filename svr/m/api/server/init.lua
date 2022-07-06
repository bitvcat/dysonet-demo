local ApiServer = Class("ApiServer")
function ApiServer:__Init()
    require("svr.m.api.server.api")
end

return ApiServer
