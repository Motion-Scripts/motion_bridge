exports('GetPlayerData', function(playerId)
    local framework = Bridge.FRAMEWORK()
    if framework == 'qbx' then
        return exports['qbx_core']:GetPlayerData(playerId)
    elseif framework == 'qb' then
        return exports['qb-core']:GetPlayerData(playerId).PlayerData
    elseif framework == 'esx' then
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then return xPlayer end
    end
    return nil
end)

exports('GetCash', function(playerId)
    local data = exports['YourResource']:GetPlayerData(playerId)
    if not data then return 0 end

    local framework = Bridge.FRAMEWORK()
    if framework == 'qbx' or framework == 'qb' then
        return data.money.cash
    elseif framework == 'esx' then
        return data.getMoney('money')
    end
    return 0
end)

exports('GetBank', function(playerId)
    local data = exports['YourResource']:GetPlayerData(playerId)
    if not data then return 0 end

    local framework = Bridge.FRAMEWORK()
    if framework == 'qbx' or framework == 'qb' then
        return data.money.bank
    elseif framework == 'esx' then
        return data.getAccount('bank').money
    end
    return 0
end)

exports('GetCID', function(playerId)
    local data = exports['YourResource']:GetPlayerData(playerId)
    if not data then return nil end

    local framework = Bridge.FRAMEWORK()
    if framework == 'qbx' or framework == 'qb' then
        return data.citizenid
    elseif framework == 'esx' then
        return data.identifier
    end
    return nil
end)

exports('GetThirst', function(playerId)
    local framework = Bridge.FRAMEWORK()
    if framework == 'qbx' then
        local data = exports['qbx_core']:GetPlayerData(playerId)
        return data.metadata['thirst']
    elseif framework == 'qb' then
        local data = exports['qb-core']:GetPlayerData(playerId).PlayerData
        return data.metadata['thirst']
    elseif framework == 'esx' then
        local val = 0
        TriggerEvent('esx_status:getStatus', playerId, 'thirst', function(status)
            val = status.val
        end)
        return val
    end
end)

exports('GetHunger', function(playerId)
    local framework = Bridge.FRAMEWORK()
    if framework == 'qbx' then
        local data = exports['qbx_core']:GetPlayerData(playerId)
        return data.metadata['hunger']
    elseif framework == 'qb' then
        local data = exports['qb-core']:GetPlayerData(playerId).PlayerData
        return data.metadata['hunger']
    elseif framework == 'esx' then
        local val = 0
        TriggerEvent('esx_status:getStatus', playerId, 'hunger', function(status)
            val = status.val
        end)
        return val
    end
end)

local isLoaded = false 
local function loaded() 
    isLoaded = true 
end 
RegisterNetEvent("QBCore:Client:OnPlayerLoaded", loaded) 
RegisterNetEvent("esx:playerLoaded", loaded) 
exports('IsPlayerLoaded', function() 
    return isLoaded 
end)
