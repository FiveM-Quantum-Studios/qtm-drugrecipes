Config = {}
----------------------------------------------------------------
Config.CheckForUpdates = true
----------------------------------------------------------------
Config.PayPhones = {
    'p_phonebox_02_s',
    'prop_phonebox_03',
    'prop_phonebox_02',
    'prop_phonebox_01c',
    'prop_phonebox_04',
    'prop_phonebox_01b'
}
----------------------------------------------------------------
local function formatRecipe(lines)
    local spacer = '\n               '-- Add or delete spaces to format the text how you want it.
    return spacer .. table.concat(lines, spacer) .. spacer
end
----------------------------------------------------------------
Config.Codes = {
    [420] = {
        recipe = formatRecipe({
            "Here is the recipe:",
            "",
            "1x  Milk",
            "3x  Sugar",
            "5x  Meow Meow",
            "6x  Love",
            "",
            "This will create a: Milkshake"
        }),
        displayMode = "text" -- Options: "text", "speech", "both"
    },
    [6969] = {
        recipe = formatRecipe({
            "Hey big dawg, I heard you want to know the recipe to the good stuff. Well the recipe is love and affection baby boy. Love you bye",
        }),
        displayMode = "speech" -- Options: "text", "speech", "both"
    }
}

Config.Language = {
    targetLabel = 'Interact',
    recipeCode = 'Recipe Code',
    recipeCodeDesc = 'Input the code of your recipe',
    notifyTitle = 'Recipes',
    wrongCode = 'Wrong Code!',
    diaglogTitle = 'Recipe Code'
}

Config.Icons = {
    inputIcon = 'hashtag',
    targetIcon = 'fa-solid fa-phone'
}
