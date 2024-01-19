include("shared.lua")

AddCSLuaFile("imgui.lua")

local imgui = include("imgui.lua")
surface.CreateFont( "AWESOME", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 75,
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

function ENT:Draw()
    self:DrawModel()

    if imgui.Entity3D2D(self, Vector(24,-4,1.6), Angle(0,90,0), 0.1) then
        surface.SetDrawColor(210, 31, 60)
        surface.DrawRect(-1380, -1420, 2845, 2370)

        imgui.End3D2D()
    end
    if imgui.Entity3D2D(self, Vector(24,-4,1.6), Angle(0,0,0), 1) then
        draw.SimpleText("PURGE", "AWESOME", -25, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        imgui.End3D2D()
    end
end

function informMenu()

end

