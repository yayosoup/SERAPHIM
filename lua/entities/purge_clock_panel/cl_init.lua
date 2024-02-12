include("shared.lua")
AddCSLuaFile("imgui.lua")

local imgui = include("imgui.lua")
local isPurgeActive = false

surface.CreateFont( "AWESOME", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 4000,
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
surface.CreateFont( "AWESOMEFOOTER", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 25,
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
surface.CreateFont( "AWESOMEACTIVE", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 240,
        weight = 50,
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

local PURGE_COLOR = Color(210, 31, 60)
local BLACK = Color(0, 0, 0)
local WHITE = Color(255, 255, 255)
local FLASH_FREQUENCY = 5
local POSITION = Vector(24,-4,1.6)
local POSITION2 = Vector(24,265,1.6)
local ANGLE_1 = Angle(0,90,0)
local ANGLE_2 = Angle(0,0,0)
local SCALE_1 = 0.1
local SCALE_2 = 0.5
local WIDTH = 2000
local HEIGHT = 2000

net.Receive("PurgeStateChanged", function()
    isPurgeActive = net.ReadBool()
    print("received purge state change")
end)


function ENT:Draw()

    if LocalPlayer():GetPos():Distance(self:GetPos()) > 2000 then
        return
    end

    self:DrawModel()
    if isPurgeActive then
        if imgui.Entity3D2D(self, POSITION, ANGLE_1, SCALE_1, WIDTH, HEIGHT) then
            -- background color
            surface.SetDrawColor(PURGE_COLOR)
            surface.DrawRect(-1380, -1420, 2845, 2370)

            surface.SetDrawColor(BLACK)
            surface.DrawRect(-1000, -1370, 1000, 2270)

            imgui.End3D2D()
        end

        if imgui.Entity3D2D(self, POSITION2, ANGLE_1, SCALE_1, WIDTH, HEIGHT) then
            -- header
            surface.SetDrawColor(255,255,255)
            surface.DrawRect(-1350, -1420, 10, 2370)


            imgui.End3D2D()
        end
        if imgui.Entity3D2D(self, POSITION2, ANGLE_1, SCALE_1, WIDTH, HEIGHT) then
            -- footer white
            surface.SetDrawColor(255,255,255)
            surface.DrawRect(-3950, -1420, 10, 2370)


            imgui.End3D2D()
        end
        if imgui.Entity3D2D(self, POSITION2, ANGLE_1, SCALE_1, WIDTH, HEIGHT) then
            -- footer black
            surface.SetDrawColor(0,0,0)
            surface.DrawRect(-4070, -1420, 120, 2370)


            imgui.End3D2D()
        end

        if imgui.Entity3D2D(self, POSITION, ANGLE_2, SCALE_2, WIDTH, HEIGHT) then
                draw.SimpleText("PURGE", "AWESOME", -45, -150, WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            imgui.End3D2D()
        end

        if imgui.Entity3D2D(self, POSITION, ANGLE_2, SCALE_2, WIDTH, HEIGHT) then
            if math.sin(CurTime() * FLASH_FREQUENCY) > 0 then
                draw.SimpleText("ACTIVE", "AWESOMEACTIVE", -45, 100, WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            imgui.End3D2D()
        end
        if imgui.Entity3D2D(self, POSITION, ANGLE_2, SCALE_2, WIDTH, HEIGHT) then
                draw.SimpleText("SERAPHIM.GG", "AWESOMEFOOTER", -45, 263, WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            imgui.End3D2D()
        end
    elseif isPurgeActive == false then
        if imgui.Entity3D2D(self, POSITION, ANGLE_1, SCALE_1, WIDTH, HEIGHT) then
            -- background color
            surface.SetDrawColor(PURGE_COLOR)
            surface.DrawRect(-1380, -1420, 2845, 2370)
            imgui.End3D2D()
        end
        if imgui.Entity3D2D(self, POSITION, ANGLE_2, SCALE_2, WIDTH, HEIGHT) then
            draw.SimpleText("NO", "AWESOME", -45, -150, WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("EVENT", "AWESOMEACTIVE", -45, 0, WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            imgui.End3D2D()
        end
    end
end

