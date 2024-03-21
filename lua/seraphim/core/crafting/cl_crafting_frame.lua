function yayo.crafting.Open() yayo.crafting.ScreenPanel = vgui.Create("YCRAFTDFrame") end

local PANEL = {}

function PANEL:Init()
    local scrw, scrh = ScrW(), ScrH()
    self:Center()
    self:MakePopup()
    self:SetTitle( "" )
    self:ShowCloseButton( true )
    self.navPanel = self:Add("YCRAFTNav")
    self.navPanel:Dock(LEFT)

    self.bodyPanel = self:Add("YCRAFTBody")
    self.bodyPanel:Dock(RIGHT)
    local frameW, frameH = scrw * .6, scrh * .63
    self:SetSize(frameW, frameH)
    self:Center()
    self.navPanel:SetWide(math.Round(frameW * .18))
    self.bodyPanel:SetWide(frameW * .82)
end

function PANEL:Paint( w, h )

    local text = "SPH v0.1 | UI WILL CHANGE | TY FOR PLAYING. FROM CALIFORNIA,WITH ♥"
    local font = yayo.util.Font( 17 )
    surface.SetFont(font)
    local textW, textH = surface.GetTextSize(text)

    local boxW = textW + 20 -- Add some padding
    local boxH = textH + 10
    local boxX = (w - boxW) / 2
    local boxY = (h / 50) - (boxH / 2)

    draw.RoundedBox(8, boxX, boxY, boxW, boxH, yayo_util.Config.BackgroundGui) -- Change the color and corner radius as needed
    draw.SimpleText(text, font, w / 2, h / 50, yayo_util.Config.HealthBarGreen, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

derma.DefineControl( "YCRAFTDFrame", "Yayo Craft DFrame", PANEL , "DFrame" )