Bridge = {}

Bridge.FRAMEWORK = function()
    if GetResourceState("qbx_core") == "started" then return "qbx"
    elseif GetResourceState("qb-core") == "started" then return "qb"
    elseif GetResourceState("es_extended") == "started" then return "esx"
    elseif GetResourceState("ox_core") == "started" then return "ox"
    else
        print("[Motion-Bridge] No framework detected")
        return nil
    end
end

Bridge.CORE = function()
    if Bridge.FRAMEWORK() == 'qbx' then return exports['qb-core']:GetCoreObject()
    elseif Bridge.FRAMEWORK() == 'qb' then return exports['qb-core']:GetCoreObject()
    elseif Bridge.FRAMEWORK() == 'esx' then return exports["es_extended"]:getSharedObject()
    elseif Bridge.FRAMEWORK() == 'ox' then return "ox_core"
    else
        print("[Motion-Bridge] No core object detected")
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
    else
        print("[Motion-Bridge] No ambulance script detected")
        return nil
    end
end

Bridge.INVENTORY = function()
    if GetResourceState('ox_inventory') == 'started' then
        return 'ox'
    elseif GetResourceState('qb-inventory') == 'started' then
        return 'qb'
    elseif GetResourceState('codem-inventory') == 'started' then
        return 'codem'
    else
        print("[Motion-Bridge] No inventory script detected")
        return nil
    end
end
