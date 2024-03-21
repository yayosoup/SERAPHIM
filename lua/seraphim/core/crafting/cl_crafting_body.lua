function yayo.crafting.IsBodyAvailable()
	if not IsValid(yayo.crafting.ScreenPanel) or not IsValid(yayo.crafting.ScreenPanel.bodyPanel) then return false end

	return true
end
function yayo.crafting.GetBody()
	if yayo.crafting.IsBodyAvailable() then
		return yayo.crafting.ScreenPanel.bodyPanel
	end
end

function yayo.crafting.ClearBody()
	if not yayo.crafting.IsBodyAvailable() then return end

	for k,v in ipairs(yayo.crafting.ScreenPanel.bodyPanel:GetChildren()) do
		v:Remove()
	end
end


local PANEL = {}

function PANEL:Init() end

function PANEL:Paint( w, h )
	draw.RoundedBoxEx(20,0,0,w,h, yayo_util.Config.BackgroundGui,false,true,false,true)
end

derma.DefineControl( "YCRAFTBody", "Yayo Craft Body", PANEL , "DPanel" )