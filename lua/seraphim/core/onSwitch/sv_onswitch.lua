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
