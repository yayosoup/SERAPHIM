local PANEL = {}
local scrw, scrh = ScrW(), ScrH()

function PANEL:Init()
    self:SetDraggable(false)
    self:SetTitle("You can do anything.")
    self:SetSize(scrw * .5, scrh * .8)
    self:Center()
    self:MakePopup()
    self.Paint = function ( me, w, h )
        surface.SetDrawColor(0,0,0,250)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("You have " .. cells .. " cells.", "DermaDefault", w / 2 , h * 0.02,
        color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

vgui.Register("YayoMutationFrame", PANEL, "DFrame")