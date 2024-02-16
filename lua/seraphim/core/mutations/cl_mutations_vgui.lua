local PANEL = {}
local scrw, scrh = ScrW(), ScrH()

function PANEL:Init()
    self:SetDraggable(false)
    self:SetTitle("You can do anything.")
    self:SetSize(scrw * .5, scrh * .8)
    self:Center()
    self:MakePopup()
    
end

function PANEL:Paint( w, h )
    local cells = LocalPlayer():GetCells()
        surface.SetDrawColor(0,0,0,250)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("You have " .. cells .. " cells.", "DermaDefault", w / 2 , h * 0.02,
        color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end


function PANEL:ScrollBar()
    if IsValid(self.scroll) then
        self.scroll:Remove()
    end

    self:Add("DScrollPanel")
    self:Dock(FILL)
    self:DrawMutations()
end

function PANEL:DrawMutations()
    if IsValid(self.mutPanel) then
        self.mutPanel:Remove()
    end
    self.mutPanel = self:Add("DPanel") 

end

vgui.Register("YayoMutationFrame", PANEL, "DFrame")