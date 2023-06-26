local ApiServer = Single("ApiServer")
function ApiServer:__init()
    require("svr.m.api.server.api")
end

return ApiServer
