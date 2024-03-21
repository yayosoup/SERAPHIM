function yayo.crafting.OpenRecipe( recipe, recipeData )
    if not yayo.crafting.IsBodyAvailable() then return end
    local body = yayo.crafting.GetBody()

    body.RecipePanel = body:Add("YCRAFTRecipe")
    body.RecipePanel:Dock( FILL )
    body.RecipePanel:SetRecipe( recipe, recipeData )
end

local PANEL = {}

function PANEL:Init()
    local scrw, scrh = ScrW(), ScrH()

end
function PANEL:SetRecipe( recipe, recipeData )

end

function PANEL:Paint( w, h )
    draw.RoundedBoxEx(20, 0, 0, w, h, color_white, false, true, false, true)
end

derma.DefineControl("YCRAFTRecipe", "YCraft Recipe", PANEL, "DPanel")