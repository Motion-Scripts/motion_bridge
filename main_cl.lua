exports('GetPlayerData', function()
    local data = nil
    if GetResourceState("qbx_core") == "started" then
        data = exports["qbx_core"]:GetPlayerData()
    elseif GetResourceState("qb-core") == "started" then
        data = exports['qb-core']:GetPlayerData()
    elseif GetResourceState("es_extended") == "started" then
        data = exports["es_extended"]:getSharedObject().GetPlayerData()
    end
    return data
end)

exports('GetCash', function()
    local amount = nil
    if GetResourceState("qbx_core") == "started" then
        amount = exports["qbx_core"]:GetPlayerData().money.cash
    elseif GetResourceState("qb-core") == "started" then
        amount = exports['qb-core']:GetPlayerData().money.cash 
    elseif GetResourceState("es_extended") == "started" then
        for _, account in pairs(exports["es_extended"]:getSharedObject()) do
            if account.name == 'money' then
                amount = account.money
                break
            end
        end
    end
    return amount
end)

exports('GetBank', function()
    local amount = nil
    if GetResourceState("qbx_core") == "started" then
        amount = exports["qbx_core"]:GetPlayerData().money.bank
    elseif GetResourceState("qb-core") == "started" then
        amount = exports['qb-core']:GetPlayerData().money.bank
    elseif GetResourceState("es_extended") == "started" then
        for _, account in pairs(exports["es_extended"]:getSharedObject().GetPlayerData().accounts) do
            if account.name == 'bank' then
                amount = account.money
                break
            end
        end
    end
    return amount
end)

exports('GetCID', function()
    local cid = nil
    if GetResourceState('qbx_core') == 'started' then
        cid = exports['qbx_core']:GetPlayerData().citizenid
    elseif GetResourceState('qb-core') == 'started' then
        cid = exports['qb-core']:GetPlayerData().citizenid or exports['qb-core']:GetPlayerData(source).PlayerData.citizenid
    elseif GetResourceState('es_extended') == 'started' then
        cid = exports['es_extended']:getSharedObject():GetPlayerData().identifier
    end
    return cid
end)

exports('GetThirst', function()
    local thirst = nil
    if GetResourceState("qbx_core") == "started" then
        thirst = exports["qbx_core"]:GetPlayerData().metadata['thirst']
    elseif GetResourceState("qb-core") == "started" then
        thirst = exports['qb-core']:GetPlayerData().metadata['thirst']
    elseif GetResourceState("es_extended") == "started" then
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.val
		end)
    end
    return thirst
end)

exports('GetHunger', function()
    local hunger = nil
    if GetResourceState("qbx_core") == "started" then
        hunger = exports["qbx_core"]:GetPlayerData().metadata['hunger']
    elseif GetResourceState("qb-core") == "started" then
        hunger = exports['qb-core']:GetPlayerData().metadata['hunger']
    elseif GetResourceState("es_extended") == "started" then
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.val
		end)
    end
    return hunger
end)

local isLoaded = false
function loaded() isLoaded = true end
RegisterNetEvent("QBCore:Client:OnPlayerLoaded", loaded)
RegisterNetEvent("esx:playerLoaded", loaded)

exports('IsPlayerLoaded', function()
    return isLoaded
end)
