util.AddNetworkString("YAYO_MUTATION_PlayerJoined")

net.Receive("YAYO_MUTATION_PlayerJoined", function(len, ply)
    if not IsValid(ply) then return end
    ply.YAYO_MUTATION = ply.YAYO_MUTATION or {}

end)

-- Load DB Tables when server is ready
hook.Add("InitPostEntity", "YAYO_MUTATION.ServerLoaded", function()
    YAYO_MUTATION.CreateDBTables()
end)
