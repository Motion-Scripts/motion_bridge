exports('Notify', function(title, subTitle, type, duration, position)
    if GetResourceState("ox_lib") == "started" then
        lib.notify({
            title = title or "",
            description = subTitle or "",
            type = type or "info",
            duration = duration or 3000,
            position = position or "top",
        })
    elseif GetResourceState("qb-core") == "started" then
        TriggerEvent('QBCore:Notify', title or "", type or "info", duration or 3000)
    elseif GetResourceState("qbx_core") == "started" then
        exports.qbx_core:Notify(title or "", type or "info", duration or 3000, subTitle or "", position or "top")
    else
        print("[Motion-Bridge] No notify script selected")
    end
end)