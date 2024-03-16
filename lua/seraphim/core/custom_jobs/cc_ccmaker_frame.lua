function CCMAKER.Open()
    vgui.Create("CCMAKERDFrame")
end

local PANEL = {}

function PANEL:Init()

end

vgui.Register("CCMAKERDFrame", PANEL, "DFrame")

function PANEL:Init()
    self:SetText( "" )
    self.Text = ""
    self.fontSize = 22
end