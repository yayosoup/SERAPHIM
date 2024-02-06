
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-- Initialize the entity
function ENT:Initialize()
    self:SetModel("models/props_wasteland/gaspump001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetHealth(100) -- Set initial health to 100

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:OnTakeDamage(dmg)
    self:SetHealth(self:Health() - dmg:GetDamage())

    if self:Health() <= 0 then
        self:Remove()
    end
end


