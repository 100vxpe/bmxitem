RegisterNetEvent('vape:bmx-useItem', function()
    local src = source 
    local success = exports.ox_inventory:RemoveItem(src, 'bmx', 1) 
    if success then
        TriggerClientEvent('vape:bmx-useItem', src) 
    else
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Erreur',
            description = 'Vous n\'avez pas de BMX!',
            type = 'error'
        })
    end
end)

RegisterNetEvent('vape:bmx-returnItem', function()
    local src = source 
    local success = exports.ox_inventory:AddItem(src, 'bmx', 1)
    if success then
    else
    end
end)


