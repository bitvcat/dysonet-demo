local ApiServer = Class("ApiServer")
function ApiServer:__init()
    require("svr.m.api.server.api")
end

return ApiServer
