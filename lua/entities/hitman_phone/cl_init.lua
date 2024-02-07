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

local NPC_COLOR = Color(255, 0, 0)
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

