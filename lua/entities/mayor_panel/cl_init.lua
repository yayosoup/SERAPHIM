include("shared.lua")

local mayorPanel = nil

function ENT:Draw()
    self:DrawModel()
end

net.Receive("isMayor", function()
    if IsValid(mayorPanel) then return end

    surface.PlaySound("placenta/crimevision/boot.ogg")

    local clr = Color(0, 255, 0)
    chat.AddText(clr, "[ACCESS GRANTED!]", color_white, " Welcome: " .. LocalPlayer():Nick() .. ", You are the mayor!")
    mayorPanel = vgui.Create("DFrame")
    mayorPanel:SetSize(ScrW() * 0.53, ScrH() * 0.4)
    mayorPanel:Center()
    mayorPanel:SetTitle("Politcal Contraption")
    mayorPanel:ShowCloseButton(false)
    mayorPanel:SetDraggable(false)
    mayorPanel:MakePopup()
    mayorPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))
    end


    local closeButton = vgui.Create("DButton", mayorPanel)
    closeButton:SetSize(ScrW() * 0.02, ScrH() * 0.02)
    closeButton:SetPos(mayorPanel:GetWide() - closeButton:GetWide(), 0)
    closeButton:SetText("X")
    closeButton:SetTextColor(Color(255,255,255))
    closeButton.Paint = function(self, w, h)
        --draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
    end
    closeButton.DoClick = function()
        mayorPanel:Close()
    end

    local rightPanel = vgui.Create("DPanel", mayorPanel)
    rightPanel:Dock(RIGHT)
    rightPanel:SetWidth(mayorPanel:GetWide() * 0.496)
    rightPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(150, 11, 11,50))
    end
    local leftPanel = vgui.Create("DPanel", mayorPanel)
    leftPanel:Dock(LEFT)
    leftPanel:SetWidth(mayorPanel:GetWide() * 0.496)
    leftPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50,50,50,50))
    end


    local taxSlider = vgui.Create("DNumSlider", leftPanel)

    taxSlider:SetText("Sales Tax")
    taxSlider:SetMin(0)
    taxSlider:SetMax(100)
    taxSlider:SetDecimals(0)
    taxSlider:SetWide(leftPanel:GetWide() * .5)
    taxSlider:SetPos(leftPanel:GetWide() * 0.15, leftPanel:GetTall() * 0.25)



    local confirmTax = vgui.Create("DButton", leftPanel)
    confirmTax:SetPos(leftPanel:GetWide() * 0.77, leftPanel:GetTall() * 2)
    confirmTax:SetSize(leftPanel:GetWide() * 0.2, leftPanel:GetTall() * 1)
    confirmTax:SetText("Confirm Tax")

    local laborSlider = vgui.Create("DNumSlider", leftPanel)

    laborSlider:SetText("Labor Tax")
    laborSlider:SetMin(0)
    laborSlider:SetMax(100)
    laborSlider:SetDecimals(0)
    laborSlider:SetWide(leftPanel:GetWide() * .5)
    laborSlider:SetPos(leftPanel:GetWide() * 0.15, leftPanel:GetTall() * 2)



    local confirmLaborTax = vgui.Create("DButton", leftPanel)
    confirmLaborTax:SetPos(leftPanel:GetWide() * 0.77, leftPanel:GetTall() * 0.5)
    confirmLaborTax:SetSize(leftPanel:GetWide() * 0.2, leftPanel:GetTall() * 1)
    confirmLaborTax:SetText("Confirm Tax")


    mayorPanel.OnClose = function()
        mayorPanel = nil
        --surface.PlaySound("placenta/crimevision/shutdown.ogg")
    end
end)


net.Receive("notMayor", function()
    local clr = Color(255, 0, 0)
    chat.AddText(clr, "[ACCESS DENIED!]", color_white, " You are not the mayor!")
end)

function foo(arguments)

end