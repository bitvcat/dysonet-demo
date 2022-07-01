-- gate
thread = 8
logpath = "."
harbor = 0
bootstrap = "snlua bootstrap"

-- path
root = "./"
lualoader = root .. "dysonet/skynet/lualib/loader.lua"
cpath = root .. "dysonet/skynet/cservice/?.so;"
    .. root .. "dysonet/cservice/?.so;"
luaservice = root .. "dysonet/skynet/service/?.lua;"
    .. root .. "dysonet/service/?.lua;"
    .. root .. "?.lua"
lua_cpath = root .. "dysonet/skynet/luaclib/?.so;"
    .. root .. "dysonet/luaclib/?.so;"
lua_path = root .. "dysonet/skynet/lualib/?.lua;"
    .. root .. "dysonet/skynet/lualib/compat10/?.lua;"
    .. root .. "dysonet/lualib/?.lua;"
    .. root .. "?.lua"

gate_slave_num = 0
