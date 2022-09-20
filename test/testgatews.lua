local skynet = require "skynet"
local websocket = require "http.websocket"

skynet.start(function ()
    local url = "ws://127.0.0.1:13001/"
    local ws_id = websocket.connect(url)
    while true do
        local msg = "hello world!"
        websocket.write(ws_id, msg)
        print(">: " .. msg)
        local resp, close_reason = websocket.read(ws_id)
        print("<: " .. (resp and resp or "[Close] " .. close_reason))
        if not resp then
            print("echo server close.")
            break
        end
        websocket.ping(ws_id)
        skynet.sleep(100)
    end
end)