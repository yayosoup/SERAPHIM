include("shared.lua")

local mayorPanel = nil  -- store the panel in a global variable

function ENT:Draw()
    self:DrawModel()
end

net.Receive("isMayor", function()
    if IsValid(mayorPanel) then return end  -- if the panel already exists, do nothing

    local clr = Color(0, 255, 0)
    chat.AddText(clr, "[ACCESS GRANTED!]", color_white, " Welcome: " .. LocalPlayer():Nick() .. ", You are the mayor!")
    mayorPanel = vgui.Create("DFrame")  -- store the panel in the global variable
    mayorPanel:SetSize(ScrW() * 0.6, ScrH() * 0.4)
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

-- i love this
























    mayorPanel.OnClose = function()  -- when the panel is closed, set the global variable to nil
        mayorPanel = nil
    end
end)


net.Receive("notMayor", function()
    local clr = Color(255, 0, 0)
    chat.AddText(clr, "[ACCESS DENIED!]", color_white, " You are not the mayor!")
end)

function foo(arguments)

end