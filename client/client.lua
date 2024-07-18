local ox_target = exports.ox_target
AddEventHandler('onClientResourceStart', function(resourceName)
    if(GetCurrentResourceName() ~= resourceName) then
        return
    else
        local optionai = {
            {
                name = 'payphones',
                icon = Config.Icons.targetIcon,
                label = Config.Language.targetLabel,
                onSelect = function()
                    TriggerEvent('qtm-drugrecipes:client:showMenu')
                end
            }
        }
        for i = 1, #Config.Payphones do 
            ox_target:addModel(Config.Payphones[i], optionai)
        end
    end
end)
function handleInput()
    local input = lib.inputDialog(Config.Language.diaglogTitle, {
        {type = 'number', label = Config.Language.recipeCode, description = Config.Language.recipeCodeDesc, required = true, icon = Config.Icons.inputIcon},
    })

    if not input then return end
    local recipeCode = input[1]
    if Config.Codes[recipeCode] then
        return Config.Codes[recipeCode]
    else
        return lib.notify({
            title = Config.Language.notifyTitle,
            description = Config.Language.wrongCode,
            type = 'error'
        })
    end
end
RegisterNetEvent('qtm-drugrecipes:client:showMenu')
AddEventHandler('qtm-drugrecipes:client:showMenu', function()
    local matchedRecipe = handleInput()
    if matchedRecipe then
        lib.alertDialog({
            header = Config.Language.notifyTitle,
            content = matchedRecipe,
            centered = true,
            cancel = true
        })
    end
end)