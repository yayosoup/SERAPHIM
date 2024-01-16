AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.m_fMaxYawSpeed = 200 -- Max turning speed
ENT.m_iClass = CLASS_CITIZEN_REBEL -- NPC Class

local sched = ai_schedule.New(" mySchedule" )

sched:EngTask("TASK_TARGET_Player", 0)
sched:EngTask("TASK_MOVE_TO_TARGET_RANGE", 60)
sched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)

function ENT:SelectSchedule()
    self:StartSchedule( sched )
end




function ENT:Initialize()
    self.nick = "Base NPC"
    self:SetModel( "models/player/Group03m/male_04.mdl" )
    self:SetHullType( HULL_HUMAN )
    self:SetHullSizeNormal()

    self:SetNPCState( NPC_STATE_ALERT )
    self:SetSolid( SOLID_BBOX )
    self:DropToFloor()

    self:SetHealth( 100 )
    self:CapabilitiesAdd( CAP_MOVE_GROUND )

    self:SetMoveType( MOVETYPE_STEP)
    self:SetSchedule(SCHED_FORCED_GO_RUN)
end

function ENT:OnTakeDamage( dmginfo )
    local atk = dmginfo:GetAttacker()
    local dmg = dmginfo:GetDamage()

    self:SetHealth( self:Health() - dmg )

    if self:Health() <= 0 && atk:IsPlayer() then
        SafeRemoveEntity( self )
        print( atk:Nick() .. " killed " .. self.nick )
    end

    return false
end

--[[ function ENT:GetAttackSpread( wep, tar)
    if ( wep:GetClass() == "weapon_shotgun") then
        return 0.5
    end
end

function ENT:GetRelationship( ent )
    if ent:IsPlayer() then
        return D_LI
    else
        return D_NU
    end
end]]



    