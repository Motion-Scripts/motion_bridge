local resourceName = GetCurrentResourceName()
if resourceName ~= "motion_bridge" then
    print("^1[ERROR]^7 Resource must be named 'motion_bridge' ")
    print("^1[ERROR]^7 Current name: '" .. resourceName .. "'")
    print("^1[ERROR]^7 Resource will now stop")
    return
end

exports('HasJob', function(playerId, jobName)
    if not playerId or not jobName then return false end

    local framework = Bridge.FRAMEWORK()

    if framework == 'esx' then
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer and xPlayer.job then
            return xPlayer.job.name == jobName
        end

    elseif framework == 'qb' or framewwork == 'qbx' then
        local Player = exports['qb-core']:GetPlayer(playerId).PlayerData
        if Player and Player.job then
            return Player.job.name == jobName
        end
    end

    return false
end)
