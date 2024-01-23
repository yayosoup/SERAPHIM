AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("zomboStart")
util.AddNetworkString("currentCells")


function ENT:Initialize()
    self:SetModel("models/props_combine/combine_interface001.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(ply)
    print("used on server!")
    net.Start("zomboStart")
    net.Send(ply)



    local cells = ply:GetPData("cells", 1)
    net.Start("currentCells")
        net.WriteInt(cells)
    net.Send(ply)
end

