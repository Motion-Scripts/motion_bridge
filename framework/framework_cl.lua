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
    local data = exports.motion_bridge:GetPlayerData(playerId)
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
    local data = exports.motion_bridge:GetPlayerData(playerId)
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
    local data = exports.motion_bridge:GetPlayerData(playerId)
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

--[[
    GetLocalPlayerGroup() -> string (client)
    HasGroup(groups) -> bool (client, checks local player)
]]
exports('GetLocalPlayerGroup', function()
    local framework = Bridge.FRAMEWORK()
    if not framework then return "user" end

    if framework == 'esx' then
        local ESX = Bridge.CORE()
        if ESX and ESX.GetPlayerData then
            local pd = ESX.GetPlayerData()
            if pd and pd.group then return pd.group end
        end
    elseif framework == 'qb' or framework == 'qbx' then
        local core = Bridge.CORE()
        if core and core.Functions and core.Functions.GetPlayerData then
            local pd = core.Functions.GetPlayerData()
            if pd then
                return pd.permission or (pd.job and pd.job.grade_name) or "user"
            end
        end
    elseif framework == 'ox' and lib.checkDependency('ox_core', '0.0.0', false) then
        local ok, Ox = pcall(require, '@ox_core.lib.init')
        if ok and Ox then
            local player = Ox.GetPlayer()
            if player and player.getGroups then
                local groups = player.getGroups()
                for _, g in ipairs({"admin", "superadmin", "god", "mod"}) do
                    if groups and groups[g] then return g end
                end
            end
        end
    end

    return "user"
end)

exports('HasGroup', function(groups)
    if not groups or type(groups) ~= "table" then return false end
    local grp = exports.motion_bridge:GetLocalPlayerGroup()
    grp = tostring(grp):lower()
    for _, g in ipairs(groups) do
        if tostring(g):lower() == grp then return true end
    end
    return false
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