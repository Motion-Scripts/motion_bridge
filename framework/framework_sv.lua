AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    if resource ~= 'motion_bridge' then
        print("^1ERROR:^7 Resource name must be ^1motion_bridge^7!")
        StopResource(resource)
    else
        print("^2Initialized ^1" .. resource .. " ^7by ^1Motion Scripts")
    end
end)


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
