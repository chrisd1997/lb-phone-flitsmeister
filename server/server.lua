ESX = nil
local SecurityToken = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function GenerateRandomToken()
    local UpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local LowerCase = "abcdefghijklmnopqrstuvwxyz"
    local Numbers = "0123456789"
    local Symbols = "!@#$%&()*+-,./;<=>?^[]{}"

    local CharacterSet = UpperCase .. LowerCase .. Numbers .. Symbols

    local KeyLength = 32
    local Output = ""

    for	i = 1, KeyLength do
        local Rand = math.random(#CharacterSet)
        Output = Output .. string.sub(CharacterSet, Rand, Rand)
    end

    SecurityToken = Output
end

ESX.RegisterServerCallback('flitsmeister:token', function(source, cb)
    if SecurityToken == nil then
        GenerateRandomToken()
    end

    cb(SecurityToken)
end)

RegisterServerEvent('flitsmeister:notification', function(token, camera)
    local _source = source

    if SecurityToken ~= token then
        print("Invalid security token for flitsmeister notification: " .. token .. " by source " .. _source .. "\n")
        return
    end

    exports["lb-phone"]:SendNotification(_source, {
        title = "Snelheidscontrole",
        content = "Deze snelheidscontrole is ingesteld op " .. camera.MaxSpeed .. " km/u.",
        icon = "https://i.imgur.com/8kQyPL4.png"
    })
end)