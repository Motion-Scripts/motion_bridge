local script = Bridge.AMBULANCE()
if not script then
    print("[Motion-Bridge] Please install a supported medical script. If you're confused, read the docs :)")
else
    print("[Motion-Bridge] Ambulance Script Detected: " .. script)
end

local function revive(id)
    if script == 'qb' then
        TriggerClientEvent('hospital:client:Revive', id)
    elseif script == 'qbx' then
        exports.qbx_medical:Revive(id)
    elseif script == 'esx' then
        TriggerClientEvent('esx_ambulancejob:revive', id)
    elseif script == 'ars' then
        TriggerClientEvent('ars_ambulancejob:healPlayer', id, {revive = true})
    elseif script == 'wasabi' then
        exports.wasabi_ambulance:RevivePlayer(id)
    elseif script == 'brutal' then
        TriggerClientEvent('brutal_ambulancejob:revive', id)
    elseif script == 'pScripts' then
        TriggerClientEvent('p_ambulancejob/client/death/revive', id)
    else
        print("[Motion-Bridge] Unknown or unsupported medical script.")
    end
end

exports("Revive", revive)