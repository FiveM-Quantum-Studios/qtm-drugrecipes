fx_version 'cerulean'
games { 'gta5' }

author 'Quantum Studios'

description 'Drug Recipes'

version '1.0.0'

lua54 'yes'


client_scripts {
    'client/client.lua'
}
server_script {
    'server/server.lua',
}

shared_scripts {
    '@qtm-lib/imports.lua',
    '@ox_lib/init.lua',
    'shared/**.lua',
}

dependencies {
	'qtm-lib',
    'ox_lib'
}

escrow_ignore {
    '**/*.lua',
}