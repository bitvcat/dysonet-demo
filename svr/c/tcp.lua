-- robot tcp

local skynet = require "skynet"
local socket = require "skynet.socket"
local socket_proxy = require "socket_proxy"
local crypt = require "skynet.crypt"
local protobuf = require "protobuf"


-- socket
local socket_start = socket_proxy.subscribe
local socket_read = function(fd)
    local ok, msg, sz = pcall(socket_proxy.read, fd)
    if not ok then
        return false
    end
    return true, skynet.tostring(msg, sz)
end
local socket_write = socket_proxy.write
local socket_close = socket_proxy.close


local tcp = {}
function tcp.start(ip, port)
    protobuf.start({ pbfile = "assets/proto/all.pb" })
    local fd = socket.open(ip, port)
    assert(fd)

    local secretKey = crypt.randomkey()
    tcp.fd = fd
    tcp.secretKey = secretKey
    tcp.publicKey = crypt.dhexchange(secretKey)
    tcp.encryptKey = ""

    socket_start(fd)
    tcp.send(nil, "client hello")
    skynet.timeout(0, function()
        while true do
            local ok, msg = socket_read(fd)
            if not ok then
                socket_close(fd)
                break
            end

            xpcall(tcp.onMessage, skynet.error, fd, msg)
        end
    end)
end

function tcp.onMessage(fd, msg)
    if not tcp.handshake then
        local _, hexstr = protobuf.decode_message(msg)
        local randomCode, sPublicHex = string.match(hexstr, "(.+)|(.+)")
        local sPublicKey = crypt.hexdecode(sPublicHex)
        local encryptKey = crypt.dhsecret(sPublicKey, tcp.secretKey)
        local randomDes = crypt.desencode(encryptKey, randomCode)
        hexstr = crypt.hexencode(randomDes) .. "|" .. crypt.hexencode(tcp.publicKey)
        local outmsg = protobuf.encode_message(nil, hexstr)
        socket_write(tcp.fd, outmsg)
        tcp.encryptKey = encryptKey
        tcp.handshake = 1
    elseif tcp.handshake == 1 then
        local _, args = protobuf.decode_message(msg)
        assert(args == "server done", args)
        tcp.handshake = 2
    elseif tcp.handshake == 2 then
        local opname, args = protobuf.decode_message(msg)
        skynet.error(opname, args)
    end
end

function tcp.send(opname, args)
    local msg = protobuf.encode_message(opname, args)
    assert(#msg <= 65535, "package too long")
    socket_write(tcp.fd, msg)
end

return tcp
