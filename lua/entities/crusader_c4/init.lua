AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/weapons/w_c4_planted.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    self:SetbombPlanted( false )
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    if not IsValid(caller) or not caller:IsPlayer() then return end

    if caller:KeyDown(IN_USE) then
        if not self.DefuseTime then
            self.DefuseTime = CurTime()
            self.activator = caller
        end
    else
        self.DefuseTime = nil
        self.activator = nil
    end
end

function ENT:Think()
    if self.DefuseTime and self.activator and self.activator:IsValid() then
        if not self.activator:KeyDown(IN_USE) then
            self.DefuseTime = nil
            return
        end

        local DefuseTime = CurTime() - self.DefuseTime
        print(DefuseTime)
        if DefuseTime >= 5 then
            self:Remove()
        end
    end
end