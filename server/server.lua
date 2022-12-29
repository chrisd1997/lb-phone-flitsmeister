RegisterServerEvent('flitsmeister:notification', function(camera)
    local _source = source

    exports["lb-phone"]:SendNotification(_source, {
        title = "Snelheidscontrole",
        content = "Deze snelheidscontrole is ingesteld op " .. camera.MaxSpeed .. " km/u.",
        icon = "https://i.imgur.com/8kQyPL4.png"
    })
end)