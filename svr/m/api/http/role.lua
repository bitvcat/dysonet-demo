local cjson = require "cjson"

local handler = {}

function handler.GET()
    return { code = 0, msg = "get role" }
end

function handler.POST(linkobj, query, body)
    logger.print(query, cjson.decode(body))
    return { code = 0, msg = "xxxx" }
end

function __hotfix()
    ApiHttp:Init()
end

return handler
