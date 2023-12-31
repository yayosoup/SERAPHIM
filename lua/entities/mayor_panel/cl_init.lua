include("shared.lua")

local mayorPanel = nil  -- store the panel in a global variable

function ENT:Draw()
    self:DrawModel()
end

net.Receive("isMayor", function()
    if IsValid(mayorPanel) then return end  -- if the panel already exists, do nothing

    local clr = Color(0, 255, 0)
    chat.AddText(clr, "[ACCESS GRANTED!]", color_white, " Welcome: " .. LocalPlayer():Nick() .. " You are the mayor!")
    mayorPanel = vgui.Create("DFrame")  -- store the panel in the global variable
    mayorPanel:SetSize(ScrW() * 0.6, ScrH() * 0.5)
    mayorPanel:Center()
    mayorPanel:SetTitle("Politcal Contraption")
    mayorPanel:MakePopup()

    local panel = vgui.Create("DPanel", mayorPanel)
    panel:Dock(FILL)
    panel.Paint = function(self, w, h)
        -- Custom panel drawing code here
    end

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