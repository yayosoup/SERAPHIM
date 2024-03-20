
local PANEL = {}

function PANEL:Init() end

function PANEL:Paint( w, h )
	draw.RoundedBoxEx(20,0,0,w,h, yayo_util.Config.BackgroundGui,false,true,false,true)
end

derma.DefineControl( "YCRAFTBody", "Yayo Craft Body", PANEL , "DPanel" )