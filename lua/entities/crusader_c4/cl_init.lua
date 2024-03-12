include("shared.lua")

local NPC_COLOR = Color( 200, 56, 56 )
local NPC_TITLE = "DEFEND YOUR CITY"
local v = Vector()
local isBombPlanted

surface.CreateFont( "SeraphimFinalsBombSub", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 45,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
} )
net.Receive("yayo_c4Planted", function()
    isBombPlanted = net.ReadBool()
    timer.Create("yayo_c4Timer", 40, 1, function()
        isBombPlanted = false
    end)

end)

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 500 then
        return
    end


    local ply = LocalPlayer()
    if ply:Team() == TEAM_CRUSADER and self:GetbombPlanted() == false then
        self:SetRenderMode(RENDERMODE_TRANSALPHA)
        self:SetColor(Color(255, 255, 255, 150)) -- Half transparency for a "ghostly" look
        self:SetMaterial("models/wireframe")
        self:DrawModel()
    else
        self:SetMaterial("")
        self:DrawShadow( false )
    end

    if self:GetbombPlanted() == true then
        self:SetRenderMode(RENDERMODE_TRANSALPHA)
        self:SetColor(Color(255, 255, 255, 255)) -- Half transparency for a "ghostly" look
        self:DrawModel()
    end


    if LocalPlayer():Team() == TEAM_CRUSADER and LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 and self:GetbombPlanted() == false then
        local z = 850
        local ang = self:GetAngles()

        ang:RotateAroundAxis(self:GetAngles():Right(), 180)
        local textpos = self:GetPos() + ang:Right() * 0 + ang:Up() * 60 + ang:Forward() * 0

        ang:RotateAroundAxis(self:GetAngles():Right(), 90)
        ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
        textpos = textpos + ang:Up()

        cam.Start3D2D(textpos, Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
            draw.SimpleText( "START YOUR MISSION", "SeraphimFinals", 2, ( v.z / 2) - z + 10, NPC_COLOR, TEXT_ALIGN_CENTER)
            draw.SimpleText( "'E' TO PLANT BOMB", "SeraphimFinals", 2, ( v.z / 2) - z + 50, NPC_COLOR, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
    if isBombPlanted then
        if LocalPlayer():Team() == TEAM_CRUSADER and LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 and self:GetbombPlanted() == true then
            local z = 850
            local ang = self:GetAngles()

            ang:RotateAroundAxis(self:GetAngles():Right(), 180)
            local textpos = self:GetPos() + ang:Right() * 0 + ang:Up() * 60 + ang:Forward() * 0

            ang:RotateAroundAxis(self:GetAngles():Right(), 90)
            ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
            textpos = textpos + ang:Up()

            local timeLeft = math.floor(timer.TimeLeft("yayo_c4Timer"))
            cam.Start3D2D(textpos, Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
                draw.SimpleText( "COMPLTE YOUR MISSION", "SeraphimFinals", 2, ( v.z / 2) - z + 10, NPC_COLOR, TEXT_ALIGN_CENTER)
                draw.SimpleText( "DEFEND: T-" .. timeLeft, "SeraphimFinals", 2, ( v.z / 2) - z + 50, NPC_COLOR, TEXT_ALIGN_CENTER)
            cam.End3D2D()
        end
        if LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 and LocalPlayer():Team() ~= TEAM_CRUSADER and self:GetbombPlanted() == true then
            local z = 850
            local ang = self:GetAngles()

            ang:RotateAroundAxis(self:GetAngles():Right(), 180)
            local textpos = self:GetPos() + ang:Right() * 0 + ang:Up() * 60 + ang:Forward() * 0

            ang:RotateAroundAxis(self:GetAngles():Right(), 90)
            ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
            textpos = textpos + ang:Up()

            local timeLeft = math.floor(timer.TimeLeft("yayo_c4Timer"))
            cam.Start3D2D(textpos, Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
                draw.SimpleText( "DEFEND YOUR CITY", "SeraphimFinals", 2, ( v.z / 2) - z + 10, NPC_COLOR, TEXT_ALIGN_CENTER)
                draw.SimpleText( "DEFUSE: " .. timeLeft, "SeraphimFinals", 2, ( v.z / 2) - z + 50, NPC_COLOR, TEXT_ALIGN_CENTER)
                draw.SimpleText( "Hold 'E' to defuse!", "SeraphimFinalsBombSub", .5, ( v.z / 2) - z + 100, NPC_COLOR, TEXT_ALIGN_CENTER)
            cam.End3D2D()
        end
    end
end

net.Receive("yayo_c4CrusaderWin", function()
    local reward = net.ReadInt(32)
    local cells = net.ReadInt(32)
    chat.AddText(Color(0, 0, 0, 255), "OCCULT", Color(50, 50, 50, 255), "|", color_white, " You have completed your mission. You have been awarded with " .. DarkRP.formatMoney( reward )
    .. " and " .. tostring( cells ) .. " cells.")

end)