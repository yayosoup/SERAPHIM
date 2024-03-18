local function OpenCCMaker()
    CCMaker.ScreenPanel = vgui.Create("CCMAKERDFrame")

end
net.Receive(
    "yayo_CCMaker_Open",
    function()
    if IsValid(CCMakerFrame) then
        CCMakerFrame:Remove()
    end

    OpenCCMaker()
    end
)
function CCMaker.Open()
    CCMaker.ScreenPanel = vgui.Create("CCMAKERDFrame")
end

local PANEL = {}

function PANEL:Init() end

function PANEL:Paint(w,h)
    local theme = DCONFIG2.GetTheme()
    draw.RoundedBoxEx(0,0,0,w,h,theme.body,false,true,false,true)
    surface.SetTextPos( w * 0.20, h * 0.05 )
    surface.SetFont( "DermaDefault" )
    surface.SetTextColor( 255, 255, 255, 255 )
    surface.DrawText( "Class Color" )
end

vgui.Register("CCMakerBody", PANEL, "DPanel")