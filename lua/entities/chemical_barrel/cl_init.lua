include("shared.lua")

local NPC_COLOR = yayo_util.Config.SeraphimBronze
local INNER_COLOR = Color( 26, 26, 32 )
local v = Vector()
local NPC_TITLE = "Empty Chemical Barrel"

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 500 then
        return
    end

    self:DrawModel()

    if LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 then
        local z = 850
        local outlineWidth, outlineHeight = 275, 50
        local innerWidth = outlineWidth - 10
        local innerHeight = outlineHeight - 10

        local ang = self:GetAngles()
        ang:RotateAroundAxis(self:GetAngles():Right(), 90)
        ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
        cam.Start3D2D(self:GetPos() + ang:Up() - Vector(0, 0, 20), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
        cam.Start3D2D(self:GetPos() + ang:Up() - Vector(0, 0, 30), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
            draw.RoundedBox(0, v.x - outlineWidth / 2, (v.z / 2) - z, outlineWidth, outlineHeight, NPC_COLOR)
            draw.RoundedBox(0, v.x - innerWidth / 2, (v.z / 2) - z + (outlineHeight - innerHeight) / 2, innerWidth, innerHeight, INNER_COLOR)
            draw.SimpleText( NPC_TITLE, "SeraphimFinalsSub", 2, ( v.z / 2) - z, NPC_COLOR, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end

