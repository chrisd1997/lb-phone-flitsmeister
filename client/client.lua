ESX = nil
local SecurityToken = nil

Citizen.CreateThread(function()
    local added, errorMessage = exports["lb-phone"]:AddCustomApp({
        identifier = "flitsmeister",
        name = "Flitsmeister",
        description = "Flitsmeister is een app die je helpt om snelheidscontroles te ontwijken.",
        ui = GetCurrentResourceName() .. "/ui/build/index.html"
    })
    if not added then
        print("Could not add app:", errorMessage)
    end

    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(7)
    end

    if SecurityToken == nil then
        ESX.TriggerServerCallback('flitsmeister:token', function(token)
            SecurityToken = token
        end)
    end
end)

local SpeedCameras = {
    -- [1] = {
    --     ['Coords'] = vector3(0, 0, 0),
    --     ['MaxSpeed'] = 80,
    -- },
} -- Updated through export, example provided above
local LastCamera = nil

function AddSpeedCameras(cameras)
    for _, camera in pairs(cameras) do
        table.insert(SpeedCameras, camera)
    end
end

Citizen.CreateThread(function() 
    while true do
        Wait(0)
    
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
    
        if (IsPedInAnyVehicle(playerPed, false)) then
            for _, camera in pairs(SpeedCameras) do
                local distance = #(playerCoords - camera.Coords)
            
                if distance < 150 and LastCamera ~= camera then
                    LastCamera = camera
                    TriggerServerEvent('flitsmeister:notification', SecurityToken, camera)
                    SendNUIMessage({
                        action = "notification",
                    })
                end
            end
        end

        if LastCamera ~= nil then
            local distance = #(playerCoords - LastCamera.Coords)
        
            if distance > 150 then
                LastCamera = nil
            end
        end
    end
end)