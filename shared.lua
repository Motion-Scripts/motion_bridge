Bridge = {}

local coreObject = nil
function GetFrameWorkObject()
    if not coreObject then
        if Bridge.FRAMEWORK == 'qbx' then coreObject = exports['qb-core']:GetCoreObject() end
        if Bridge.FRAMEWORK == 'qb' then coreObject = exports['qb-core']:GetCoreObject() end
        if Bridge.FRAMEWORK == 'esx' then coreObject = exports["es_extended"]:getSharedObject() end
      end
      return coreObject
end


Bridge.FRAMEWORK = function()
    if GetResourceState("qbx_core") == "started" then
        return "qbx"
    elseif GetResourceState("qb-core") == "started" then
        return "qb"
    elseif GetResourceState("es_extended") == "started" then
        return "esx"
    else
        print("[Motion-Bridge] No framework detected")
        return nil
    end
end

Bridge.AMBULANCE = function()
    if GetResourceState('qbx_medical') == 'started' then
        return 'qbx'
    elseif GetResourceState('qb-ambulancejob') == 'started' then
        return 'qb'
    elseif GetResourceState('es_extended') == 'started' then
        return 'esx'
    elseif GetResourceState('wasabi_ambulance') == 'started' then
        return 'wasabi'
    elseif GetResourceState('ars_ambulancejob') == 'started' then
        return 'ars'
    elseif GetResourceState('brutal_ambulancejob') == 'started' then
        return 'brutal'
    elseif GetResourceState('p_ambulancejob') == 'started' then
        return 'pScripts'
    end
    return nil
end

Bridge.INVENTORY = function()
    if GetResourceState('ox_inventory') == 'started' then
        return 'ox'
    elseif GetResourceState('qb-inventory') == 'started' then
        return 'qb'
    elseif GetResourceState('codem-inventory') == 'started' then
        return 'codem'
    elseif server_config.customInventory then
        return 'custom'
    end
    return nil
end