fx_version 'cerulean'
game 'gta5'

name 'motion_bridge'
description 'Motion Bridge - A bridge for scripts made by Motion Scripts'
author 'Motion Scripts'
version '1.0.3'

lua54 'yes'

client_scripts {
    '**/*_cl.lua'
}

server_scripts {
    '**/*_sv.lua',
    '_versioncheck.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'bridge.lua'
}