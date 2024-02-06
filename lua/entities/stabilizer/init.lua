AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

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
    self:SetHealth(self:Health() - dmg:GetDamage()) -- Subtract the damage taken from the entity's health

    if self:Health() <= 0 then -- If the entity's health is 0 or less
        self:Remove() -- Remove the entity
    end
end

hook.Add("PlayerDeath", "Testing!!", function()
    local count = GetGlobalInt("tech_trash")
    SetGlobalInt("tech_trash", count + 1)
end)