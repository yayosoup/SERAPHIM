YAYO_TRASH_REWARD = 2500

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
    self:SetisRunning(false)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:OnTakeDamage(dmg)
    self:SetHealth(self:Health() - dmg:GetDamage())

    if self:Health() <= 0 then
        self:SetisRunning(false)
        self:StopSound("ambient/machines/machine3.wav")
        self:EmitSound("kidneydagger/printer_death.wav")
    end
end

function ENT:Use(Act)
    if self:GetisRunning() == false and Act:IsValid() then
        Act:ChatPrint("You have turned on the stabilizer!")
        self:EmitSound("ambient/machines/machine3.wav")
        self:SetisRunning(true)
    end
end