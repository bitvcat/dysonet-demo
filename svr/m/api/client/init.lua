local ApiClient = Class("ApiClient")
function ApiClient:__Init()
    require("svr.m.api.client.task")
end

return ApiClient
