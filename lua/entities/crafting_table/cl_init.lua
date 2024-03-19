include("shared.lua")

local NPC_COLOR = yayo_util.Config.SeraphimBronze
local INNER_COLOR = Color( 26, 26, 32 )
local v = Vector()
local NPC_TITLE = "Crafting Table"

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 500 then
        return
    end


    self:DrawModel()

    if LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 then
        local z = 50
        local outlineWidth, outlineHeight = 275, 50
        local innerWidth = outlineWidth - 10
        local innerHeight = outlineHeight - 10
        local outlineWidth2, outlineHeight2 = 275, 250
        local innerWidth2 = outlineWidth2 - 10
        local innerHeight2 = outlineHeight2 - 10

        local ang = self:GetAngles()
        ang:RotateAroundAxis( ang:Forward(), 90 )
        ang:RotateAroundAxis( ang:Right(), -90 )
        local ang2 = self:GetAngles()
        ang2:RotateAroundAxis( ang:Forward(), 0 )
        ang2:RotateAroundAxis( ang:Right(), -90 )

        local moveUpDistance = 31.1
        local forwardDistance = 25
        local moveUpDistance2 = 36.8
        local forwardDistance2 = -10
        cam.Start3D2D( self:GetPos() + (self:GetAngles():Up() * -1.7) + (self:GetAngles():Up() * moveUpDistance) + (self:GetAngles():Forward() * forwardDistance), ang, 0.1 )
            draw.RoundedBox(0, v.x - outlineWidth / 2, (v.z / 2) - z, outlineWidth, outlineHeight, NPC_COLOR)
            draw.RoundedBox(0, v.x - innerWidth / 2, (v.z / 2) - z + (outlineHeight - innerHeight) / 2, innerWidth, innerHeight, INNER_COLOR)
            draw.SimpleText( NPC_TITLE, "SeraphimFinalsSub", 2, ( v.z / 2) - z, NPC_COLOR, TEXT_ALIGN_CENTER)
        cam.End3D2D()
        cam.Start3D2D( self:GetPos() + (self:GetAngles():Up() * -1.7) + (self:GetAngles():Up() * moveUpDistance2) + (self:GetAngles():Forward() * forwardDistance2), ang2, 0.1 )
            draw.RoundedBox(0, v.x - outlineWidth2 / 2, (v.z / 2) - z, outlineWidth2, outlineHeight2, NPC_COLOR)
            draw.RoundedBox(0, v.x - innerWidth2 / 2, (v.z / 2) - z + (outlineHeight2 - innerHeight2) / 2, innerWidth2, innerHeight2, INNER_COLOR)
            draw.SimpleText( "Ingredients", "SeraphimFinalsSub", 0, ( v.z / 3) - 10, NPC_COLOR, TEXT_ALIGN_CENTER)
            draw.SimpleText( "Chemicals: " .. self:GetChemical(), "SeraphimFinalsSub", 0, ( v.z / 3) + 20, NPC_COLOR, TEXT_ALIGN_CENTER)
            draw.SimpleText( "Tech Trash: " .. self:GetTechTrash(), "SeraphimFinalsSub", 0, ( v.z / 3) + 50, NPC_COLOR, TEXT_ALIGN_CENTER)
            draw.SimpleText( "Wood: " .. self:GetWood(), "SeraphimFinalsSub", 0, ( v.z / 3) + 80, NPC_COLOR, TEXT_ALIGN_CENTER)
            draw.SimpleText( "Metal: " .. self:GetMetal(), "SeraphimFinalsSub", 0, ( v.z / 3) + 110, NPC_COLOR, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end

