util.AddNetworkString("blood_switch")

hook.Add("OnNPCKilled", "DropArmorOnZombieDeath", function(npc, attacker, inflictor)
    if npc:GetClass() == "npc_zombie" then  -- Replace "npc_zombie" with the class of the zombie NPCs
        local armor = ents.Create("item_suit")  -- Replace "item_suit" with the class of the armor item
        if IsValid(armor) then
            armor:SetPos(npc:GetPos())
            armor:Spawn()
        end
    end
end)

-- Function to remove an entity after a delay
local function removeEntityDelayed(entity, delay)
    timer.Simple(delay, function()
        if IsValid(entity) then
            entity:Remove()
        end
    end)
end

-- Hook into NPC death
hook.Add("OnNPCKilled", "RemoveDeadNPC", function(npc, attacker, inflictor)
    -- Check if the killed entity is an NPC
    if IsValid(npc) and npc:IsNPC() then
        local delayToRemove = 10 -- Adjust the delay as needed (in seconds)
        removeEntityDelayed(npc, delayToRemove)
    end
end)