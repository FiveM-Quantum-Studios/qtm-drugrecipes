local ox_target = exports.ox_target

local function addPayPhoneTargets()
    local options = {
        {
            name = 'payphones',
            icon = Config.Icons.targetIcon,
            label = Config.Language.targetLabel,
            distance = 1,
            onSelect = function(data)
                TriggerEvent('qtm-drugrecipes:client:showMenu', data.entity)
            end
        }
    }

    for _, phoneModel in ipairs(Config.PayPhones) do
        ox_target:addModel(phoneModel, options)
    end
end

local function handleInput()
    local input = lib.inputDialog(Config.Language.diaglogTitle, {
        {type = 'number', label = Config.Language.recipeCode, description = Config.Language.recipeCodeDesc, required = true, icon = Config.Icons.inputIcon},
    })

    if not input then return nil end

    local recipeCode = input[1]
    if Config.Codes[recipeCode] then
        return recipeCode
    else
        qtm.Notification(nil, Config.Language.notifyTitle, 'error', Config.Language.wrongCode)
        return nil
    end
end

local function showRecipeMenu(phoneEntity)
    local recipeCode = handleInput()
    if not recipeCode then return end

    local recipeData = Config.Codes[recipeCode]
    if not recipeData then return end

    local recipeText = recipeData.recipe
    local displayMode = recipeData.displayMode

    if displayMode == "speech" or displayMode == "both" then
        local playerPed = PlayerPedId()
        local animDictPress = "anim@mp_radio@medium_apment"
        local animDictHold = "amb@world_human_stand_mobile@female@standing@call@base"
        local animNamePress = "button_press_kitchen"
        local animNameHold = "base"
        local phoneModel = `prop_phone_ing`
        local boneIndex = GetPedBoneIndex(playerPed, 57005)
        local phoneProp = nil

        lib.requestAnimDict(animDictPress, 2000)
        lib.requestAnimDict(animDictHold, 2000)
        lib.requestModel(phoneModel, 2000)

        TaskPlayAnim(playerPed, animDictPress, animNamePress, 8.0, -8.0, -1, 1, 0, false, false, false)

        Wait(3000)

        phoneProp = CreateObject(phoneModel, 0, 0, 0, true, true, false)
        AttachEntityToEntity(phoneProp, playerPed, boneIndex, 0.10676461365642, 0, -0.011121844481322, 137.59160177613, 54.663763340008, -98.02764965762, true, true, false, true, 1, true)

        TaskPlayAnim(playerPed, animDictHold, animNameHold, 8.0, -8.0, -1, 1, 0, false, false, false)

        SendNUIMessage({
            action = "playTTS",
            text = recipeText
        })

        RegisterNUICallback("ttsFinished", function()
            ClearPedTasks(playerPed)
            if phoneProp then
                DeleteEntity(phoneProp)
                phoneProp = nil
            end
            RemoveAnimDict(animDictPress)
            RemoveAnimDict(animDictHold)
            SetModelAsNoLongerNeeded(phoneModel)
        end)
    end

    if displayMode == "text" or displayMode == "both" then
        lib.alertDialog({
            header = Config.Language.notifyTitle,
            content = recipeText,
            centered = true,
            cancel = true
        })
    end
end

AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        addPayPhoneTargets()
    end
end)

RegisterNetEvent('qtm-drugrecipes:client:showMenu', showRecipeMenu)
