AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("yayo_c4Planted")
util.AddNetworkString("yayo_c4CrusaderWin")
util.AddNetworkString("yayo_c4CrusaderLost")
util.AddNetworkString("yayo_c4CrusaderDefuser")
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
local function CreateExplosion(inf, atk, org)
    util.BlastDamage(inf, atk, org, 300, 50)
    util.ScreenShake(org, 5, 5, 1, 300)

    local effectData = EffectData()
    effectData:SetStart(org)
    effectData:SetOrigin(org)
    effectData:SetScale(1)
    effectData:SetMagnitude(1)

    util.Effect("Explosion", effectData)
end

function ENT:Use(activator, caller)
    if not IsValid(caller) or not caller:IsPlayer() then return end

    if caller:Team() == TEAM_CRUSADER and self:GetbombPlanted() == false then
        self.Crusader = caller
        print(self.Crusader:Nick() .. " has planted the bomb!")
        self:SetbombPlanted( true )
        net.Start("yayo_c4Planted")
            net.WriteBool(self:GetbombPlanted())
        net.Broadcast()

        self:EmitSound("weapons/c4/c4_plant.wav")
        timer.Create("bomb_timer", 2, 1, function()
            if not IsValid(self) then return end
                self:SetbombDefused( false )
                self:Remove()
        end)
        self:CreateBeepTimer(1)
    end

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
function ENT:OnRemove()
    if self:GetbombDefused() == false then
        local reward = 125000 + math.random(1, 10000 )
        local rewardCells = math.random( 1, 5 )
        net.Start("yayo_c4CrusaderWin")
            net.WriteInt(reward, 32)
            net.WriteInt(rewardCells, 32)
        net.Send(self.Crusader)
        self.Crusader:addMoney( reward )
        self.Crusader:AddCells( rewardCells )

        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos()) -- Where is hits
        util.Effect("ThumperDust", effectdata)
        util.Effect("Explosion", effectdata)
        effectdata:SetOrigin(self:GetPos()) -- Where is hits
        effectdata:SetNormal(Vector(0, 0, 1)) -- Direction of particles
        effectdata:SetEntity(self.Crusader) -- Who done it?
        effectdata:SetScale(1.3) -- Size of explosion 
        effectdata:SetRadius(67) -- What texture it hits
        effectdata:SetMagnitude(18) -- Length of explosion trails
        util.Effect("m9k_gdcw_cinematicboom", effectdata)
        util.ScreenShake(self:GetPos(), 2000, 255, 2.5, 1250)
        util.BlastDamage(self, self, self:GetPos(), 500, 500)
    end
end

function ENT:CreateBeepTimer(beepTick)
    timer.Create("beepbeepbeep", beepTick, 0, function()
        if not IsValid(self) then return end
        local choice math.Rand(1,2)
        if choice == 1 then
            self:EmitSound("weapons/c4/c4_beep1.wav")
        else
            self:EmitSound("weapons/c4/c4_click.wav")
        end

        local timeLeft = timer.TimeLeft("bomb_timer") or 0
        if timeLeft < 5 and beepTick ~= 0.5 then
            timer.Remove("beepbeepbeep")
            self:CreateBeepTimer(0.5) -- Create a new one with faster interval.
        elseif timeLeft < 2 and beepTick ~= 0.25 then
            timer.Remove("beepbeepbeep") -- Remove the old timer.
            self:CreateBeepTimer(0.4) -- Even faster for the last 2 seconds.
        end
    end)
end

function ENT:Think()
    if self.DefuseTime and self.activator and self.activator:IsValid() then
        if not self.activator:KeyDown(IN_USE) then
            self.DefuseTime = nil
            return
        end

        local DefuseTime = CurTime() - self.DefuseTime
        if DefuseTime >= 5 then
            self:SetbombDefused( true )
            self:Remove()
        end
    end
end
