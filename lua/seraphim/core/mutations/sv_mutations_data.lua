YAYO_MUTATION.Data = {}
TEXT = TEXT or {}
YAYO_MUTATION.Keys = {"hasHothead", "hasBitrot", "hasSecondwind", "hasRicochet", "hasRedemption", "hasChanneledOccult", "hasChanneledEsoteric", "hasAdrenaline", "hasEnmitySense"}
if not file.IsDir("seraphim", "DATA") then file.CreateDir("seraphim") end
if not file.IsDir("seraphim/mutation", "DATA") then file.CreateDir("seraphim/mutation") end

function TEXT:SaveMutations( ply )
    print("saving")
    local mut = {}

    for _, key in pairs( YAYO_MUTATION.Keys ) do
        local mutAdd = ply:GetNWBool( key )
        if mutAdd == true then
            mut[key] = ply:GetNWBool( key )
        end
    end

    local mutationsJson = util.TableToJSON( mut )
    file.Write("seraphim/mutation/" .. (ply:SteamID64() or "0") .. ".txt", mutationsJson)
end

function TEXT:LoadMutations( ply )
    print("loading mutations for " .. ply:Nick())
    local json = file.Read("seraphim/mutation/" .. (ply:SteamID64() or "0") .. ".txt", "DATA")

    if json then
        local inv = util.JSONToTable( json )

        if inv then
            for k,v in pairs ( inv ) do
                ply:SetNWBool( k, v )
                ply:SetNWInt( "mutationCount", ply:GetNWInt( "mutationCount" ) + 1 )
            end
    end
end

function TEXT:ResetMutations( pl )
    print(pl:Nick() .. " has reset their mutations")
    for _, key in pairs( YAYO_MUTATION.Keys ) do
        local checkKey = pl:GetNWBool( key )
        if checkKey then
            pl:SetNWInt( "mutationCount", pl:GetNWInt( "mutationCount" ) - 1)
            pl:SetNWBool( key, false )
        end
    end
    TEXT:SaveMutations( pl )
end

function YAYO_MUTATION.Data.Run(func_name, ...)
    local func = YAYO_MUTATION.Data.Text[func_name]

        if func then
            return func(YAYO_MUTATION.Data.Text, ...)
        end
    end
end