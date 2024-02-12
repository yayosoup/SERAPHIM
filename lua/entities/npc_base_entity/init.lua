AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
    test = {
        "models/Humans/Group03m/Male_03.mdl",
        "models/Humans/Group03m/Male_04.mdl",
    }
    timer.Create("Timer", 5, 0, function()
        local chooseModel = table.Random(test)
        self:SetModel(chooseModel)

        self:SetSequence("idle_all_01")
    end)
    self:SetHullType( HULL_HUMAN )
    self:SetUseType( SIMPLE_USE )
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_IDLE)
    self:SetSolid( SOLID_BBOX)
    self:SetCollisionGroup( COLLISION_GROUP_NONE )


    self:Give("weapon_rpg")
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then phys:Wake() end
end

function ENT:AcceptInput( name, activator, caller )
    print("hello")
end