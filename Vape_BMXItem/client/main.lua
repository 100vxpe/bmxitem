local spawnedbmx = nil
local isBmxSpawning = false  

RegisterNetEvent('vape:bmx-useItem', function()
    if spawnedbmx or isBmxSpawning then
        return
    end

    isBmxSpawning = true

    TriggerServerEvent('vape:bmx-useItem')

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed) + vector3(0, 2, 0)
    local bmxModel = `bmx`

    RequestAnimDict('amb@world_human_clipboard@male@base')
    while not HasAnimDictLoaded('amb@world_human_clipboard@male@base') do
        Wait(10)
    end

    TaskPlayAnim(playerPed, 'amb@world_human_clipboard@male@base', 'base', 8.0, -8.0, 2000, 49, 0, false, false, false)
    Wait(2000)
    RemoveAnimDict('amb@world_human_clipboard@male@base')

    RequestModel(bmxModel)
    local timeout = 0
    while not HasModelLoaded(bmxModel) and timeout < 50 do
        Wait(10)
        timeout = timeout + 1
    end

    if timeout >= 50 then
        isBmxSpawning = false  
        return
    end

    local success, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)
    spawnedbmx = CreateVehicle(bmxModel, coords.x, coords.y, (success and groundZ or coords.z) + 1.0, GetEntityHeading(playerPed), true, false)
    SetVehicleOnGroundProperly(spawnedbmx)
    SetModelAsNoLongerNeeded(bmxModel)

    exports.ox_target:addLocalEntity(spawnedbmx, {
        {
            name = 'delete_bmx',
            label = 'Récupérer',
            icon = 'fa-solid fa-bicycle',
            event = 'bmx:delete'
        }
    })

    isBmxSpawning = false
end)
RegisterNetEvent('bmx:delete', function(data)
    if DoesEntityExist(spawnedbmx) then
        local playerPed = PlayerPedId()
        RequestAnimDict('amb@prop_human_bum_bin@base')
        while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
            Wait(10)
        end

        TaskPlayAnim(playerPed, 'amb@prop_human_bum_bin@base', 'base', 8.0, -8.0, 2000, 49, 0, false, false, false)
        Wait(2000)
        RemoveAnimDict('amb@prop_human_bum_bin@base')
        DeleteEntity(spawnedbmx)
        spawnedbmx = nil
        TriggerServerEvent('vape:bmx-returnItem')
    else
    end
end)


