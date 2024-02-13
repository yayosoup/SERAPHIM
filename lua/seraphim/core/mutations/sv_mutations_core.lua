util.AddNetworkString("YAYO_MUTATION_PlayerJoined")

net.Receive("YAYO_MUTATION_PlayerJoined", function(len, ply)
    if not IsValid(ply) then return end
    TEXT:LoadMutations( ply )

end)

-- Load DB Tables when server is ready
hook.Add("InitPostEntity", "YAYO_MUTATION.ServerLoaded", function()
    if true then return end
end)

hook.Add("Tick", "YAYO_MUTATION.SaveOnWrite", function()
    for _, ply in ipairs( player.GetAll() ) do
        if ply.NextMutationSave and ply.NextMutationSave < CurTime() then
            print("saving for: " .. ply:Nick() )
            TEXT:SaveMutations( ply )
        end
    end
end)

hook.Add("PlayerDeath", "TeSTINGFORSURE", function(ply)
    print(ply:GetNWBool("hasHotHead"))
    ply:SetNWBool("hasHotHead", true)
end)