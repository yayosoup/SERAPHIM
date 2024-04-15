function yayo.crafting.OpenRecipe( recipe, recipeData )
    if not yayo.crafting.IsBodyAvailable() then return end
    local body = yayo.crafting.GetBody()

    body.RecipePanel = body:Add( "YCRAFTRecipe" )
    body.RecipePanel:Dock( FILL )
    body.RecipePanel:SetRecipe( recipe, recipeData )
end

local PANEL = {}

function PANEL:Init()
    local scrw, scrh = ScrW(), ScrH()

end
function PANEL:SetRecipe( recipe, recipeData )
    self.recipe = recipe
    self.recipeData = recipeData
end

function PANEL:Paint( w, h )
    if self.recipe == "red" then
        draw.RoundedBoxEx(20, 0, 0, w, h, Color( 255, 0 ,0 ), false, true, false, true)
    elseif self.recipe == "blue" then
        --draw.RoundedBoxEx(20, 0, 0, w, h, Color( 0, 0, 255 ), false, true, false, true)
        draw.SimpleText("good morning angel", yayo.util.Font( 50 ), w / 2, h / 10, yayo_util.Config.HealthBarGreen, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

derma.DefineControl("YCRAFTRecipe", "YCraft Recipe", PANEL, "DPanel")