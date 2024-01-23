include("shared.lua")

local zomboPanel = nil

function ENT:Draw()
    self:DrawModel()
end


net.Receive("zomboStart", function()
    if IsValid(zomboPanel) then return end

    print("xombo received on client :3")

    zomboPanel = vgui.Create("DFrame")
    zomboPanel:SetSize(ScrW() * 0.25, ScrH() * 0.4)
    zomboPanel:Center()
    zomboPanel:SetTitle("You can do anything.")
    zomboPanel:ShowCloseButton(false)
    zomboPanel:SetDraggable(false)
    zomboPanel:MakePopup()
    zomboPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))
    end

    local closeButton = vgui.Create("DButton", zomboPanel)
    closeButton:SetSize(ScrW() * 0.02, ScrH() * 0.02)
    closeButton:SetPos(zomboPanel:GetWide() - closeButton:GetWide(), 0)
    closeButton:SetText("X")
    closeButton:SetTextColor(Color(255,255,255))
    closeButton.Paint = function(self, w, h)
        --draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
    end
    closeButton.DoClick = function()
        if IsValid(zomboPanel) then
            zomboPanel:Close()
        end
    end

    local cells = net.ReadInt(32)
    local cellsCheck = vgui.Create("DLabel", zomboPanel)
    cellsCheck:SetPos(ScrW() * 0.006, ScrH() * 0.03)
    cellsCheck:SetText("You have " .. cells .. " cells.")
    cellsCheck:SetAutoStretchVertical(true)
    cellsCheck:SetWrap(true)
    cellsCheck:SetContentAlignment(7)
    cellsCheck:SetSize(zomboPanel:GetWide() * 0.98, ScrH() * 0.1)

    zomboPanel.OnClose = function()
        zomboPanel = nil
        --surface.PlaySound("placenta/crimevision/shutdown.ogg")
    end
end)
