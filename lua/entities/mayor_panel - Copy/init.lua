AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("isMayor")
util.AddNetworkString("notMayor")

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_intmonitor001.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(ply)
    if ply:isMayor() then
        print(ply:Nick() .. " is the Mayor and has used the panel!")
        net.Start("isMayor")
        net.Send(ply)
    else
        net.Start("notMayor")
        net.Send(ply)
    end
end