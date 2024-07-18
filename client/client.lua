local ox_target = exports.ox_target
AddEventHandler('onClientResourceStart', function(resourceName)
    if(GetCurrentResourceName() ~= resourceName) then
        return
    else
        local optionai = {
            {
                name = 'payphones',
                icon = 'fa-solid fa-key',
                label = 'Interact',
                onSelect = function()
                    TriggerEvent('tiz-drugrecipes:client:showMenu')
                end
            }
        }
        for i = 1, #Config.Payphones do 
            ox_target:addModel(Config.Payphones[i], optionai)
        end
    end
end)
function handleInput()
    local input = lib.inputDialog('Dialog title', {
        {type = 'number', label = 'Recipe Code', description = 'Input the code of your recipe', required = true, icon = 'hashtag'},
    })

    if not input then return end
    local recipeCode = input[1]
    if Config.Codes[recipeCode] then
        return Config.Codes[recipeCode]
    else
        return lib.notify({
            title = 'Recipe',
            description = 'Wrong Code',
            type = 'error'
        })
    end
end
RegisterNetEvent('tiz-drugrecipes:client:showMenu')
AddEventHandler('tiz-drugrecipes:client:showMenu', function()
    local matchedRecipe = handleInput()
    if matchedRecipe then
        lib.alertDialog({
            header = 'Recipe',
            content = matchedRecipe,
            centered = true,
            cancel = true
        })
    end
end)