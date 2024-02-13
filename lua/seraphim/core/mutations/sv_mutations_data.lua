-- Create DB tables if they don't exist
function YAYO_MUTATION.CreateDBTables()
    sql.Query("CREATE TABLE IF NOT EXISTS yayo_mutation (steamid TEXT, mutation TEXT, PRIMARY KEY (steamid, mutation))")
end

-- Load player's mutations from the sqllite db
function YAYO_MUTATION.LoadDBPlayer(ply, callback)
    local steamID = ply:SteamID64()
    local data = sql.Query("SELECT * FROM yayo_mutation WHERE steamid = '" .. steamID .. "'")
    if data then
        callback(data)
    else
        callback(nil)
    end
end