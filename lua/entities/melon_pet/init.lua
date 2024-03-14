AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_junk/watermelon01.mdl")
    self:SetSolid(SOLID_BBOX)
    self:PhysicsInit(SOLID_BBOX)
    self:SetCollisionGroup( COLLISION_GROUP_WORLD )
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:GetPhysicsObject():Wake()


    local hat = ents.Create("prop_physics")
    hat:SetModel("models/props/cs_office/snowman_hat.mdl")
    hat:SetPos(self:GetPos() + Vector(0, 0, 50))
    hat:Spawn()
    hat:SetParent(self)
    hat:SetCollisionGroup(COLLISION_GROUP_WORLD)
    hat:SetLocalPos(Vector(0, 0, 7))
    hat:SetLocalAngles(Angle(0, 0, 7))

    print(self:GetOwner())
end

function ENT:Think()
    local owner = self:CPPIGetOwner()
    if IsValid(owner) then
        local direction = (owner:GetPos() - self:GetPos()):GetNormalized()
        self:GetPhysicsObject():ApplyForceCenter(direction * 250)

        if self:GetPos():Distance(owner:GetPos()) > 500 then
            self:SetPos(owner:GetPos() - Vector(0, 0, 50)) -- Adjust the Vector as needed
        end

        if owner:GetVelocity():Length() == 0 then
            self:GetPhysicsObject():SetVelocity(Vector(0, 0, 0))
        end
    else
        self:Remove()
    end
    self:NextThink(CurTime())
    return true
end