fx_version 'cerulean'
game 'gta5'

name "drdev_weaponban"
description "This script implement a system where specific players can be denied the use of weapons, and it maintains a list of denied users both on the server and client sides for synchronization. The server handles the database operations, while the client handles notifying and disarming players."
author "Roby"
version "1.0.0"
server_script '@oxmysql/lib/MySQL.lua'

shared_scripts {
	'shared/*.lua',
	'@es_extended/imports.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua',
}
