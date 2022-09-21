CONST.GATE_TCP = 0x01   -- tcp 网关
CONST.GATE_KCP = 0x02   -- kcp 网关
CONST.GATE_WS = 0x04    -- ws 网关
CONST.GATE_WSS = 0x08   -- wss 网关
CONST.GATE_HTTP = 0x10  -- http 网关
CONST.GATE_HTTPS = 0x20 -- https 网关

-- gate protocol name
CONST.GATE = {
    [CONST.GATE_TCP] = "tcp",
    [CONST.GATE_KCP] = "kcp",
    [CONST.GATE_WS] = "ws",
    [CONST.GATE_WSS] = "wss",
    [CONST.GATE_HTTP] = "http",
    [CONST.GATE_HTTPS] = "https",
}