include("shared.lua")
surface.CreateFont( "SeraphimFinalsSub", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 45,
        weight = 500,
} )
surface.CreateFont( "SeraphimFinalsSubSub", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 25,
        weight = 500,
} )

local NPC_COLOR = Color(    200, 56, 56 )
local INNER_COLOR = Color( 26, 26, 32 )
local v = Vector()
local NPC_TITLE = "Ringing Phone"

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 500 then
        return
    end

    self:DrawModel()

    if LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 then
        local z = 850
        local outlineWidth, outlineHeight = 330, 100
        local innerWidth = outlineWidth - 10
        local innerHeight = outlineHeight - 10
        local ang = self:GetAngles()

        ang:RotateAroundAxis(self:GetAngles():Right(), 180)
        local textpos = self:GetPos() + ang:Right() * 0 + ang:Up() * 30 + ang:Forward() * 0

        ang:RotateAroundAxis(self:GetAngles():Right(), 90)
        ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
        textpos = textpos + ang:Up()

        cam.Start3D2D(textpos, Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
            draw.RoundedBox(0, v.x - outlineWidth / 2, (v.z / 2) - z, outlineWidth, outlineHeight, NPC_COLOR)
            draw.RoundedBox(0, v.x - innerWidth / 2, (v.z / 2) - z + (outlineHeight - innerHeight) / 2, innerWidth, innerHeight, INNER_COLOR)
            draw.SimpleText( NPC_TITLE, "SeraphimFinals", 2, ( v.z / 2) - z + 10, NPC_COLOR, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end
local phonePanel = nil  -- store the panel in a global variable

net.Receive("YAYO_STARTCALL", function()
    if IsValid(phonePanel) then return end
    surface.PlaySound("kidneydagger/radio.wav")

    local scrw, scrh = ScrW(), ScrH()
    phonePanel = vgui.Create("DFrame")
    phonePanel:SetSize(scrw * 0.5, scrh * 0.8)
    phonePanel:Center()
    phonePanel:SetTitle("")
    phonePanel:MakePopup()
    phonePanel.Paint = function(self, w, h)
        surface.SetDrawColor( INNER_COLOR )
        surface.DrawRect(0, 0, w, h)

    end

    local phoneBackground = vgui.Create("DPanel", phonePanel)
    phoneBackground:SetSize(phonePanel:GetWide() * 0.30, phonePanel:GetTall() * 0.75)
    phoneBackground:SetPos(phonePanel:GetWide() * 0.10, phonePanel:GetTall() * 0.1)
    phoneBackground.Paint = function(self, w, h)
        surface.SetDrawColor(38, 38, 47,50)
        draw.RoundedBox(8, 0, 0, w, h, Color(38, 38, 47,255))
    end

    local modelPanel = vgui.Create("DModelPanel", phonePanel)
    modelPanel:SetSize(phonePanel:GetWide() * 0.5, phonePanel:GetTall())
    modelPanel:SetPos(0, 0)
    modelPanel:SetModel("models/props_trainstation/payphone001a.mdl")

    modelPanel:SetCamPos(Vector(50, 0, 0))
    modelPanel:SetLookAt(Vector(0, 0, 0))

    modelPanel.LayoutEntity = function(panel, entity)
        entity:SetAngles(Angle(0, 45, 0))
    end

    local rightHalf = vgui.Create("DPanel", phonePanel)
    rightHalf:SetSize(phonePanel:GetWide() * 0.5, phonePanel:GetTall() * 0.6)
    rightHalf:SetPos(phonePanel:GetWide() * 0.45, phonePanel:GetTall() * 0.1)
    rightHalf.Paint = function(self, w, h)
        surface.SetDrawColor(150, 11, 11,50)
        draw.RoundedBox(8, 0, 0, w, h, Color(150, 11, 11,50))
    end



    local callButton = vgui.Create("DButton", phonePanel)
    callButton:SetSize(rightHalf:GetWide(), rightHalf:GetTall() * 0.12)
    callButton:SetPos(rightHalf:GetWide() * 0.9, rightHalf:GetTall() * 1.15)
    callButton:SetText("")
    callButton.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color( 16, 148, 56 ))
        draw.RoundedBox(0, 5, 5, w-10, h-10, Color(38, 38, 47, 255))
    end
    callButton.DoClick = function()
        phonePanel:Close()
        net.Start("YAYO_ANSWERCALL")
        net.SendToServer()
    end

    local noButton = vgui.Create("DButton", phonePanel)
    noButton:SetSize(rightHalf:GetWide(), rightHalf:GetTall() * 0.12)
    noButton:SetPos(rightHalf:GetWide() * 0.9, rightHalf:GetTall() * 1.27)
    noButton:SetText("")
    noButton.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(  113, 19, 11  ))
        draw.RoundedBox(0, 5, 5, w-10, h-10, Color(38, 38, 47, 255))
    end
    noButton.DoClick = function()
        phonePanel:Close()
    end


    local closeButton = vgui.Create("DButton", phonePanel)
    closeButton:SetSize(ScrW() * 0.02, ScrH() * 0.02)
    closeButton:SetPos(phonePanel:GetWide() - closeButton:GetWide(), 0)
    closeButton:SetText("X")
    closeButton:SetTextColor(Color(255,255,255))
    closeButton.Paint = function(self, w, h)
        --draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
    end
    closeButton.DoClick = function()
        phonePanel:Close()
    end

     phonePanel.OnClose = function()
        phonePanel = nil
        --surface.PlaySound("placenta/crimevision/shutdown.ogg")
    end

end)























local function cleanupWaypoint()
    hook.Remove("HUDPaint", "Waypoint")
end

local function DrawWaypoint(vector, location)
    print("Drawing waypoint")
    local dist = 1500^2
    hook.Add("HUDPaint", "Waypoint", function()
        if LocalPlayer():GetPos():DistToSqr(vector) > dist then
            local screenPos = vector:ToScreen() -- Store the screen position in a separate variable
            draw.SimpleText(location, "SeraphimFinalsSub", screenPos.x, screenPos.y, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            cleanupWaypoint()
            LocalPlayer():EmitSound("music/hl2_song29.mp3")
        end
    end)
end



net.Receive("YAYO_BEACH", function()
    local waypointVector = Vector(3108.808105, -1379.017090, -139.968750) -- Replace with your desired vector coordinates
    local location = "Beach"
    DrawWaypoint(waypointVector, location)

end)

net.Receive("YAYO_SEWER", function()
    print("YAYO SEWER")
    local waypointVector = Vector(-24.183817, 2725.296875, -373.968750) -- Replace with your desired vector coordinates
    local location = "SEWER"
    DrawWaypoint(waypointVector, location)

end)

net.Receive("YAYO_CHURCH", function()
    print("YAYO CHURCH")
    local waypointVector = Vector(1310.759521, 5248.273438, -131.968750) -- Replace with your desired vector coordinates
    local location = "Church"
    DrawWaypoint(waypointVector, location)

end)

net.Receive("YAYO_TRAINYARD", function()
    print("YAYO TRAINYARD")
    local waypointVector = Vector(-4251.983398, -6386.353516, -119.968750) -- Replace with your desired vector coordinates
    local location = "TRAINYARD"
    DrawWaypoint(waypointVector, location)

end)
