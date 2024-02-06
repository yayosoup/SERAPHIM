AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_lab/reciever01d.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:StartTouch(ent)
    print(ent:GetClass() .. "touching")
    if ent:IsPlayer() then return end
    if ent:GetClass() != "stabilizer" then return end
    local count = ent:Gettech_trash()
    print(count)
    ent:Settech_trash(count + 1)
    ent:EmitSound("ambient/machines/slicer3.wav")
    self:Remove()
end