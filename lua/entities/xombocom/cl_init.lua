include("shared.lua")

local zomboPanel = nil

function ENT:Draw()
    self:DrawModel()
end

function YAYO_MUTATIONS.Open(cells)
    if IsValid(YAYO_MUTATIONS.Frame) then return end
    print(cells)
    local scrw, scrh = ScrW(), ScrH()
    YAYO_MUTATIONS.Frame = vgui.Create("DFrame")
    YAYO_MUTATIONS.Frame:SetSize(scrw * .5, scrh * .8)
    YAYO_MUTATIONS.Frame:Center()
    YAYO_MUTATIONS.Frame:SetTitle("You can do anything.")
    YAYO_MUTATIONS.Frame:MakePopup()
    YAYO_MUTATIONS.Frame.Paint = function(me,w,h)
        surface.SetDrawColor(0,0,0,250)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("You have " .. cells .. " cells.", "DermaDefault", w / 2 , h * 0.02,
        color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    local scroll = vgui.Create("DScrollPanel", YAYO_MUTATIONS.Frame)
    scroll:Dock(FILL)

    local frameH = YAYO_MUTATIONS.Frame:GetTall()
    local yspace = frameH * 0.05
    for k,v in pairs(YAYO_MUTATIONS.Mutations) do
        print(v.name)
        local itemPanel = vgui.Create("DPanel", scroll)
        itemPanel:DockMargin(0,0,0,yspace)
        itemPanel:Dock(TOP)
        itemPanel:SetTall(frameH * 0.1)
        itemPanel.Paint = function(me,w,h)
            draw.SimpleText(v.name, "DermaDefault", w * .05 , h * 0.1,
            color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end

net.Receive("zomboStart", function(len, ply)
    if IsValid(mayorPanel) then return end
    local cells = net.ReadInt(32)
    YAYO_MUTATIONS.Open(cells)
end)
-- hello