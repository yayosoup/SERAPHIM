AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props/cs_militia/table_shed.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use( ply )
    ply:ChatPrint("Tech Trash: " .. self:GetTechTrash())
    ply:ChatPrint("Chemical: " .. self:GetChemical())
end

function ENT:StartTouch( ent )
    if not ent:GetClass() == "tech_trash" or not ent:GetClass() == "chemical_filled_barrel" or not ent:GetClass() == "wood" or not ent:GetClass() == "metal" then return end
    if ent:GetClass() == "tech_trash" then
        ent:Remove()
        local tech = self:GetTechTrash()
        self:SetTechTrash(tech + 1)
    end
    if ent:GetClass() == "chemical_filled_barrel" then
        ent:Remove()
        local chem = self:GetChemical()
        self:SetChemical(chem + 1)
    end
    if ent:GetClass() == "wood" then
        ent:Remove()
        local wood = self:GetWood()
        self:SetWood(wood + 1)
    end
    if ent:GetClass() == "metal" then
        ent:Remove()
        local metal = self:GetMetal()
        self:SetMetal(metal + 1)
    end
end
