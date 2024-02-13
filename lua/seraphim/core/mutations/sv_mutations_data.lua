YAYO_MUTATION.Data = {}
TEXT = {}

if not file.IsDir("seraphim", "DATA") then file.CreateDir("seraphim") end
if not file.IsDir("seraphim/mutation", "DATA") then file.CreateDir("seraphim/mutation") end

function TEXT:LoadMutations( ply )
    local json = file.Read("seraphim/mutation/" .. (ply:SteamID64() or "0") .. ".txt", "DATA")

    if json then
    local inv = util.JSONToTable( json )

    if inv then
        for k,v in pairs ( inv ) do
            ply:SetNWBool( k, v )
        end
    end
end

function TEXT:SaveMutations( ply )
    print("saving")
    local keys = {"hasHotHead", "hasBitRot"}
    local mut = {}

    for _, key in pairs( keys ) do
        mut[key] = ply:GetNWBool( key )
    end

    local mutationsJson = util.TableToJSON( mut )
    file.Write("seraphim/mutation/" .. (ply:SteamID64() or "0") .. ".txt", mutationsJson)
end

function YAYO_MUTATION.Data.Run(func_name, ...)
    local func = YAYO_MUTATION.Data.Text[func_name]

        if func then
            return func(YAYO_MUTATION.Data.Text, ...)
        end
    end
end