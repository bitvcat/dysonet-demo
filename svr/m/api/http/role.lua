local handler = {}

function handler.GET()
end

function handler.POST(query, body)
    xlogger.print(query, body)
    return { code = 0, msg = "xxxx" }
end

function __hotfix()
    ApiHttp:Init()
end

return handler
