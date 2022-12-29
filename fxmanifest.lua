fx_version "cerulean"
game "gta5"

title "Flitsmeister App for LB Phone"
author "Heuptasje"

client_scripts {"client/*.lua"}
server_scripts {"server/*.lua"}

files {
    "ui/**/*",
}

ui_page 'ui/build/index.html'

exports {
    "AddSpeedCameras",
    "SetListening"
}