include("shared.lua")

local mayorPanel = nil  -- store the panel in a global variable

function ENT:Draw()
    self:DrawModel()
end

net.Receive("isMayor", function()
    if IsValid(mayorPanel) then return end  -- if the panel already exists, do nothing

    surface.PlaySound("placenta/crimevision/boot.ogg")

    local clr = Color(0, 255, 0)
    chat.AddText(clr, "[ACCESS GRANTED!]", color_white, " Welcome: " .. LocalPlayer():Nick() .. ", You are the mayor!")
    mayorPanel = vgui.Create("DFrame")  -- store the panel in the global variable
    mayorPanel:SetSize(ScrW() * 0.53, ScrH() * 0.4)
    mayorPanel:Center()
    mayorPanel:SetTitle("Politcal Contraption")
    mayorPanel:ShowCloseButton(false)  -- hide the close button, which also hides the minimize and maximize buttons
    mayorPanel:SetDraggable(false)  -- make the panel undraggable
    mayorPanel:MakePopup()
    mayorPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0))
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
    rightPanel:Dock(RIGHT)  -- set the panel to dock on the right side
    rightPanel:SetWidth(mayorPanel:GetWide() * 0.496)  -- set the width to half of the panel's width
    rightPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(150, 11, 11,50))
    end
    local leftPanel = vgui.Create("DPanel", mayorPanel)
    leftPanel:Dock(LEFT)  -- set the panel to dock on the right side
    leftPanel:SetWidth(mayorPanel:GetWide() * 0.496)  -- set the width to half of the panel's width
    leftPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50,50,50,50))
    end

    local center = vgui.Create("DButton", leftPanel)
    center:SetText("0")
    center:SetSize(25,30)
    center:Center()


    local taxSlider = vgui.Create("DNumSlider", leftPanel)

    taxSlider:SetText("Sales Tax")
    taxSlider:SetMin(0)
    taxSlider:SetMax(100)
    taxSlider:SetDecimals(0)

    taxSlider:SetPos(leftPanel:GetWide() * 0.19, leftPanel:GetTall() * 0.25)
    taxSlider:SetWide(leftPanel:GetWide() * 0.5)


    local confirmTax = vgui.Create("DButton", leftPanel)
    confirmTax:SetPos(leftPanel:GetWide() * 0.77, leftPanel:GetTall() * 0.5)
    confirmTax:SetSize(110, 28)
    confirmTax:SetText("Establish Legal Theft")
    confirmTax:SetFont("DermaDefault")
    confirmTax.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
        draw.SimpleText(self:GetText(), self:GetFont(), w / 2, h / 2, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end


    mayorPanel.OnClose = function()  -- when the panel is closed, set the global variable to nil
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