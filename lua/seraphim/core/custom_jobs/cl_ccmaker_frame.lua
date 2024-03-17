local PANEL = {}
print("hello bro")

function PANEL:Init()
    local scrw, scrh = ScrW(), ScrH()
    self:SetDraggable( false )
    self:SetTitle( "" )
    self:ShowCloseButton( true )
    self:MakePopup()

    local frameW, frameH = scrw * 0.4, scrh * .65
    self:SetSize( frameW, frameH )
    self:Center()
    self.bodyPanel = self:Add("DCONFIG2Body")
    self.bodyPanel:Dock( RIGHT )
    self.bodyPanel:SetWide( frameW )

    self:CreateButton(self.bodyPanel, "Hitman Access", 0, self.bodyPanel:GetTall() * 5, self.bodyPanel:GetWide() * 0.50 , 30)
    self:CreateTextBox(self.bodyPanel, "", self.bodyPanel:GetWide() * 0.02, self.bodyPanel:GetTall() * 0.2, self.bodyPanel:GetWide() * 0.45 , 30)
end
function PANEL:Paint(w,h)

end
function PANEL:CreateButton(parent, text, posX, posY, width, height)
    local btn = parent:Add("DButton")
    btn:SetSize(width, height)
    btn:SetPos(posX, posY)
    btn:SetText(text)
    return btn
end
function PANEL:CreateTextBox(parent, text, posX, posY, width, height)
    local btn = parent:Add("DTextEntry")
    btn:SetSize(width, height)
    btn:SetPos(posX, posY)
    btn:SetText(text)
    return btn
end

vgui.Register("CCMAKERDFrame", PANEL, "DFrame")
