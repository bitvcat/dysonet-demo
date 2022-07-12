-- 策划配置相关
local skynet = require "skynet"
local sharetable = require "skynet.sharetable"
local lfs = require "lfs"

local Cfg = Class("Cfg")
function Cfg:__Init(path, master)
    self._path = path -- 配置路径
    self._master = master
    self._cache = false -- 配置缓存
    self._files = self:ListCfg() -- 配置文件列表
    self._userAddrs = {}
end

function Cfg:ListCfg()
    local files = {}
    local path = self._path
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            if string.match(file, "(.+)%.lua$") then
                local f = path .. '/' .. file
                local attr = lfs.attributes(f)
                files[f] = attr.modification
            end
        end
    end
    return files
end

function Cfg:LoadCfg()
    for f, _ in pairs(self._files) do
        sharetable.loadfile(f)
    end
end

function Cfg:InitCfg()
    self._cache = {}
    for f, _ in pairs(self._files) do
        local pattern = string.format("%s/(.+)%%.lua", self._path)
        local cfgName = string.match(f, pattern)
        self._cache[cfgName] = sharetable.query(f)
    end

    -- 向主服务注册
    --skynet.call(8, "lua", "internal", "register", skynet.self())
end

function Cfg:Get(name, id, field)
    local data = self._cache[name]
    assert(data, name)
    if id then
        data = data[id]
    end
    if field and data then
        data = data[field]
    end
    return data
end

function Cfg:UpdateCfg(files)
    -- 找到变化的
    local ofiles = self._files
    local nfiles = self:ListCfg()
    self._files = nfiles

    if skynet.self() == self._master then
        for f, tm in pairs(nfiles) do
            if ofiles[f] ~= tm then
                sharetable.loadfile(f)
            end
        end
        for _, addr in ipairs(self._userAddrs) do
            --skynet.call(addr, "lua")
        end
    else
        for _, f in ipairs(files) do
            local pattern = string.format("%s/(.+)%.lua", self._path)
            local cfgName = string.match(f, pattern)
            self._cache[cfgName] = sharetable.query(f)
        end
    end
end

function Cfg:Register(addr)
    self._userAddrs[#self._userAddrs + 1] = addr
end
