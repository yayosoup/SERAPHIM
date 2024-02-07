YAYO_TRAINYARD = 6

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-- Initialize the entity
function ENT:Initialize()
    self:SetModel("models/props_trainstation/payphone001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetHealth(100)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:OnTakeDamage(dmg)

end

function ENT:Use(Act)
    if Act:Team() ~= TEAM_HITMAN then
        Act:ChatPrint("You are not a hitman!")
        return
    end

end
