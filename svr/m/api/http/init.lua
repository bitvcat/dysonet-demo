local ApiHttp = Class("ApiHttp")
function ApiHttp:__init()
    self:register("/role", require("svr.m.api.http.role"))
end

function ApiHttp:register(url, module)
    assert(type(module) == "table", url)
    self[url] = module
end

return ApiHttp
