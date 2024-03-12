util.AddNetworkString("blood_switch")
util.AddNetworkString("yayo_crusaderCooldown")
util.AddNetworkString("yayo_crusaderAppeared")
util.AddNetworkString("yayo_martyrCooldown")

hook.Add("OnNPCKilled", "DropArmorOnZombieDeath", function(npc, attacker, inflictor)
    if npc:GetClass() == "npc_zombie" then  -- Replace "npc_zombie" with the class of the zombie NPCs
        local armor = ents.Create("item_suit")  -- Replace "item_suit" with the class of the armor item
        if IsValid(armor) then
            armor:SetPos(npc:GetPos())
            armor:Spawn()
        end
    end
end)

local QTE = {}
QTE.Active = false
QTE.StartTime = 0
QTE.Duration = 2 -- Duration of the QTE window in seconds
QTE.Key = KEY_SPACE -- The key the player needs to press; KEY_SPACE is an example

-- Initialize the QTE
function QTE:Start( ply )
    self.Active = true
    self.StartTime = CurTime()
    hook.Add("Think", "QTESkillCheck", function() self:Update() end)
    hook.Add("KeyPress", "QTEKeyPress", function(ply, key) self:KeyPress(ply, key) end)

    -- Optionally, show visual/auditory cues here
    print("Skill Check Started! Press SPACE within 2 seconds.")
end

-- Update the QTE state
function QTE:Update()
    if self.Active and (CurTime() - self.StartTime) > self.Duration then
        self:Fail()
    end
end

-- Handle key press
function QTE:KeyPress(ply, key)
    if self.Active and key == self.Key then
        self:Success()
    end
end

-- Handle success
function QTE:Success()
    self:Reset()
    print("Skill Check Passed!")
    -- Implement success logic here, e.g., repairing a generator faster
end

-- Handle failure
function QTE:Fail()
    self:Reset()
    print("Skill Check Failed.")
    -- Implement failure logic here, e.g., causing a loud noise alerting the killer
end

-- Reset the QTE
function QTE:Reset()
    self.Active = false
    hook.Remove("Think", "QTESkillCheck")
    hook.Remove("KeyPress", "QTEKeyPress")
end

-- To start a Skill Check, simply call QTE:Start()
-- This can be tied to specific game events, e.g., when repairing something
concommand.Add("skillcheck", function( ply ) QTE:Start( ply ) end)

local ent = ents.Create("crusader_c4")
if not IsValid(ent) then return end
ent:SetOwner( ply )
ent:SetPos(Vector(-1685.119019, -60, -160.968750))
ent:SetAngles(Angle(0, 0, 0.000000))
ent:Spawn()
local phys = ent:GetPhysicsObject()
if IsValid(phys) then
    phys:EnableMotion(false)
end