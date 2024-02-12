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

local NPC_COLOR = Color(255,215,0)
local INNER_COLOR = Color( 26, 26, 32 )
local v = Vector()
local NPC_TITLE = "Stabilizer"

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 500 then
        return
    end

    self:DrawModel()

    if LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 then
        local z = 700
        local outlineWidth, outlineHeight = 330, 200
        local innerWidth = 300
        local innerHeight = 229
        local ang = self:GetAngles()
        ang:RotateAroundAxis(self:GetAngles():Right(), 180)
        local textpos = self:GetPos() + ang:Right() * 0 + ang:Up() * 15 + ang:Forward() * -9
        ang:RotateAroundAxis(self:GetAngles():Right(), 90)
        ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
        textpos = textpos + ang:Up()

        local states = {"Running.", "Running..", "Running..."}
        local index = (math.floor(CurTime() / 0.5) % #states) + 1

        cam.Start3D2D(textpos, ang, 0.1)
            draw.RoundedBox(0, v.x - innerWidth / 2, -z + (outlineHeight - innerHeight) / 2, innerWidth, innerHeight, Color(210, 31, 60))
            draw.SimpleText( NPC_TITLE, "SeraphimFinals", 2, -z + 10, Color(255,255,255), TEXT_ALIGN_CENTER)
            local tech_trash = self:Gettech_trash()
            draw.SimpleText( "Tech Trash: " .. tech_trash, "SeraphimFinalsSubSub", 2, -z , Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

            if self:GetisRunning() == true then
                draw.RoundedBox(0, -76, -615, 155, 38, Color(0, 0, 0))
                draw.SimpleText( states[index], "SeraphimFinalsSub", 2, -z + 100, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            else
                draw.RoundedBox(0, -76, -615, 155, 38, Color(0, 0, 0))
                draw.SimpleText( "Not Running", "SeraphimFinalsSub", 2, -z + 100, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            end

        cam.End3D2D()
    end
end
