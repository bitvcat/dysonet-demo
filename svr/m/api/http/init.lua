local ApiHttp = Class("ApiHttp")
function ApiHttp:__Init()
    self:Register("/role", require("svr.m.api.http.role"))
end

function ApiHttp:Register(url, module)
    assert(type(module) == "table", url)
    self[url] = module
end

return ApiHttp
