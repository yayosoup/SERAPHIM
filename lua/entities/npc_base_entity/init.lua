AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
    self:SetModel( "models/Humans/Group03m/Male_04.mdl" )
    self:SetHullType( HULL_HUMAN )
    self:SetUseType( SIMPLE_USE )
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_IDLE)
    self:SetSolid( SOLID_BBOX)
    self:SetCollisionGroup( COLLISION_GROUP_NONE )


    local phys = self:GetPhysicsObject()
    if phys:IsValid() then phys:Wake() end
end

function ENT:AcceptInput( name, activator, caller )

end