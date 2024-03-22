yayo.crafting = yayo.crafting or {}
yayo.crafting.recipes = {
    {
        name = "C-AE Phasma",
        ingredients = {
            ["tech_trash"] = 10,
            ["chemicals"] = 20,
            ["metal"] = 15,
            ["uranium"] = 5
        },
        class_name = "sfw_phasma",
        desc = "Energy sword of unknown origin.",
        callback = function()
            yayo.crafting.OpenRecipe( name )
        end
    },
    {
        name = "C-AE Phasma",
        ingredients = {
            ["tech_trash"] = 10,
            ["chemicals"] = 20,
            ["metal"] = 15,
            ["uranium"] = 5
        },
        class_name = "sfw_phasma",
        desc = "Energy sword of unknown origin. "
    },
}