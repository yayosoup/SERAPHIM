include("shared.lua")
AddCSLuaFile("imgui.lua")

local imgui = include("imgui.lua")
local isPurgeActive = false

surface.CreateFont( "AWESOME", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 400,
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
        size = 85,
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
surface.CreateFont(
  "vestedfont_32",
  {
    font = "FinalsNotoSans",
    size = 100,
    weight = 500,
    antialias = true,
  }
)

local PURGE_COLOR = Color(210, 31, 60)

net.Receive("PurgeStateChanged", function()
    isPurgeActive = net.ReadBool()
    print("received purge state change")
end)


function ENT:Draw()

    if LocalPlayer():GetPos():Distance(self:GetPos()) > 2000 then
        return
    end

    local ang = self:GetAngles()
    ang:RotateAroundAxis(ang:Right(), 0)
    ang:RotateAroundAxis(ang:Up(), 0)
    local pos = self:GetPos()
    local offset = ang:Up() * 2
    pos = pos + offset
    local s = .1

    local w = 74 * (3 / s)
    local h = 39 * (3 / s)
    local z = -w / 2
    local z2 = -h / 2

    self:DrawModel()

    if isPurgeActive == false then
        cam.Start3D2D(pos, ang, s)
            local lpx = z + 20
            local lpy = z2 + h * .1 - 895
            local lpw = w - 40
            local lph = h - h * .1 - 40
            local pph = lph / 10

            surface.SetDrawColor(PURGE_COLOR)
            surface.DrawRect(-1185, -1450, 2370, 2850)
            draw.RoundedBox(0, z + 20, z2 + h * .1 + 150, w - 40, h - h * .1 - 40, Color(0, 0, 0, 150))
            draw.RoundedBox(0, z + 20, z2 + h * .1 - 900, w - 40, h - h * .1 - 40, Color(0, 0, 0, 150))
            for k, v in pairs(VSCOREBOARDDATA) do
                if not (k > 10) then
                    local cury = lpy + pph * (k - 1)
                    draw.RoundedBox(0, lpx, cury, lpw, pph, Color(30, 30, 30, k % 2 == 0 and 130 or 0))
                    draw.SimpleText(k, "vestedfont_32", lpx + 10, cury, Color(255, 255, 255))
                    draw.SimpleText(v.nick, "vestedfont_32", lpx + 40, cury, Color(255, 255, 255))
                    draw.SimpleText("$" .. string.Comma(v.money), "vestedfont_32", lpw - 1100, cury, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                end
            end
            for k, v in pairs(DarkRP.getLaws()) do
                if not (k > 10) then
                    local cury = lpy + pph * (k - 1)
                    draw.RoundedBox(2, lpx, cury + 1050, lpw, pph, Color(30, 30, 30, k % 2 == 0 and 130 or 0))
                    draw.SimpleText(k, "vestedfont_32", lpx + 10, cury + 1050, Color(255, 255, 255))
                    draw.SimpleText(v, "vestedfont_32", lpx + 80, cury + 1050, Color(255, 255, 255))
                end
            end
            draw.RoundedBox(0, z + 500, z2 + h * .1 + 1250, w - 1000, h - h * .1 - 750, Color(0, 0, 0, 255))
            draw.SimpleText("NO EVENT ACTIVE", "AWESOME", lpx + 520, lpx + 1900, Color(255, 255, 255))

            draw.RoundedBox(0, z - 75, z2 + h * .1 + 1730, w + 150, h - h * .1 - 895, Color(0, 0, 0, 255))
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawLine(z - 75, z2 + h * .1 + 1730, z - 75 + w + 150, z2 + h * .1 + 1730)
            local boxCenterX = z - 75 + (w + 165) / 2
            local boxCenterY = z2 + h * .1 + 1730 + (h - h * .1 - 895) / 2

            draw.SimpleText("SERAPHIM.GG", "AWESOMEFOOTER", boxCenterX, boxCenterY, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)


        cam.End3D2D()
    end
end

