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
