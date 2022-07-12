### 目录结构
```
.
├── dysonet                     -- 这里是引擎（第三方模块、服务等）
├── etc                         -- 这里放skynet启动配置、cluste节点配置等
├── assets                      -- 这里放游戏资产
│   ├── config                  -- excel 以及导表生成的 lua 配置文件
│   └── proto                   -- 协议文件
├── common                      -- 这里放游戏公共模块（跟游戏业务相关的模块）
├── docs                        -- 这里放服务器文档
├── tools                       -- 这里放工具链、脚本等
├── skynet                      -- 这个是skynet可执行程序，用于启动各游戏服
├── *.shell                     -- 这个是用于操作服务器的相关脚本，例如：start.sh、stop.sh 等等
└── svr                         -- 这里放各个游戏服
    ├── m       --地图服
    ├── u       --玩家服
    └── w       --世界服
```

### 全局table
- Cfg       策划Lua配置相关
- xlogger   日志模块(封装了对xlogger c服务的操作，以及开发期日志打印)


### 通用单例
- App       每个dysonet服务都有一个App单例对象，用来管理一个Lua服务
- Api       各种Api接口的单例对象，例如：ApiGM、ApiClient、ApiServer、ApiHttp等
