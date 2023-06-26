local ApiClient = Single("ApiClient")
function ApiClient:__init()
    require("svr.m.api.client.task")
end

function ApiClient:judgLink(link)

end

return ApiClient
