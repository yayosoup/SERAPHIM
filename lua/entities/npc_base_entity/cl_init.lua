include("shared.lua")
AddCSLuaFile("imgui.lua")

local imgui = include("imgui.lua")

local NPC_COLOR = Color(255, 0, 0)
local NPC_TITLE = "Example NPC"
local v = Vector()


function ENT:Draw()

    self:DrawModel()

    v.z = math.sin( CurTime() ) * 250

    local width, height = 330, 80
    local z = 850
    if imgui.Entity3D2D(self, Vector(0,-150,0), Angle(0,90,90), 1) then
            surface.SetDrawColor(Color(255,0,0))
            draw.SimpleText(NPC_TITLE, "DermaLarge", width/2, 0, NPC_COLOR, TEXT_ALIGN_CENTER)
        imgui.End3D2D()
    end
end
