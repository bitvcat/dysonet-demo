local ApiClient = Extend("ApiClient")
function ApiClient:C2S_Task_Finish(player, args, session)
    player:sendToClient("S2C_Task_Finish", { taskId = 1001 })
end
