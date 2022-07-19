author 'Xakra <Discord:Xakra#8145:https://discord.gg/kmsqB6xQjH>'
version '1.0.0'
description 'xakra_utils'

fx_version "adamant"
lua54 "on"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game "rdr3"

client_scripts {
	'config.lua',
	'client/client.lua',
	'client/warmenu.lua',
}

server_scripts {
	'config.lua',
	'server/server.lua'
}
