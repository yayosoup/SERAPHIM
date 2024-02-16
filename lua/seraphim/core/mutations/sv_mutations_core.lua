util.AddNetworkString("YAYO_MUTATION.PlayerJoined")
util.AddNetworkString("YAYO_MUTATION.PlayerPurchaseAttempt")
util.AddNetworkString("YAYO_MUTATION.OpenMenu")

net.Receive("YAYO_MUTATION.PlayerJoined", function(len, ply)
    if not IsValid(ply) then return end
    print("Player joined: " .. ply:Nick() )
    TEXT:LoadMutations( ply )

end)
/*

hook.Add("Tick", "YAYO_MUTATION.SaveOnWrite", function()
    for _, ply in ipairs( player.GetAll() ) do
        if ply.NextMutationSave and ply.NextMutationSave < CurTime() then
            print("saving for: " .. ply:Nick() )
            TEXT:SaveMutations( ply )
        end
    end
end)

*/



hook.Add("PlayerDeath", "TeSTINGFORSURE", function(ply)
    print(ply:GetNWBool("hasHotHead"))
    ply:QueueMutationSave()
    ply:SetNWBool("hasHotHead", true)
end)

net.Receive("YAYO_MUTATION.PlayerPurchaseAttempt", function( len, ply )
    local mutation = net.ReadString()
    if YAYO_MUTATION.Catalog[mutation] then
        print("Player " .. ply:Nick() .. " is attempting to purchase " .. mutation)
    end
end)

hook.Add("PlayerSay", "YAYO_MUTATION.OpenMenu", function( ply, text )
    if string.lower(text) ~= string.lower("!mut") then return end
    net.Start("YAYO_MUTATION.OpenMenu")
    net.Send(ply)
end)