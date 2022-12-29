local SpeedCameras = {
    -- [1] = {
    --     ['Coords'] = vector3(0, 0, 0),
    --     ['MaxSpeed'] = 80,
    -- },
} -- Updated through export, example provided above
local LastCamera = nil
local Listening = false

function AddSpeedCameras(cameras)
    for _, camera in pairs(cameras) do
        table.insert(SpeedCameras, camera)
    end
end

function SetListening(listening)
    Listening = listening
    print('[Flitsmeister] Listening:', listening)
end

Citizen.CreateThread(function() 
    while true do
        Wait(0)
    
        if Listening then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
        
            if (IsPedInAnyVehicle(playerPed, false)) then
                for _, camera in pairs(SpeedCameras) do
                    local distance = #(playerCoords - camera.Coords)
                
                    if distance < 150 and LastCamera ~= camera then
                        LastCamera = camera
                        TriggerServerEvent("flitsmeister:notification", camera)
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
    end
end)