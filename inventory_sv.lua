local script = Bridge.INVENTORY()
if not script then
    print("[Motion-Bridge] Please install a supported inventory script. If you're confused, check the readme :)")
else
    print("[Motion-Bridge] Inventory Script Detected: " .. script)
end

function addItem(id, item, amount)
    if script == 'ox' then
        exports.ox_inventory:AddItem(id, item, amount)
    elseif script == 'qb' then
        exports['qb-inventory']:AddItem(id, item, amount)        
    elseif script == 'codem' then
        exports['codem-inventory']:AddItem(id, item, amount)
    else
        print("[Motion-Bridge] Unknown or unsupported inventory script. This action has failed.")
    end
end

exports("AddItem", addItem)

function removeItem(id, item, amount)
    if script == 'ox' then
        exports.ox_inventory:RemoveItem(id, item, amount)
    elseif script == 'qb' then
        exports['qb-inventory']:RemoveItem(id, item, amount)        
    elseif script == 'codem' then
        exports['codem-inventory']:RemoveItem(id, item, amount)
    else
        print("[Motion-Bridge] Unknown or unsupported inventory script. This action has failed.")
    end
end

exports("RemoveItem", removeItem)

function itemCount(id, item)
    if script == 'ox' then
        return exports.ox_inventory:GetItemCount(id, item)
    elseif script == 'qb' then
        return exports['qb-inventory']:GetItemCount(id, item)
    elseif script == 'codem' then
       return exports['codem-inventory']:GetItemsTotalAmount(id, item)
    else
        print("[Motion-Bridge] Unknown or unsupported inventory script. This action has failed.")
    end
end

exports("ItemCount", itemCount)