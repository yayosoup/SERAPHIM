-- Prepare file structure to receive data
function CCMaker.PrepareData()
    local main = CCMaker.Data.SaveDir

    if not file.Exists( main, "DATA" ) then
        file.CreateDir( main )
    end

    for dir, active in pairs( CCMaker.Data.SubFolders ) do
        dir = mainPath .. "/" .. dir
        -- if the sub folder does not exist, create it
        if not file.Exists(dir, "DATA") then
            file.CreateDir(dir)
        end
    end
end

-- sava data of type job
-- TODO: SAVE JOB DATA BASED OFF STEAM ID FOR INIT SPAWN RETRIEVAL
function CCMaker.SaveJobData( job )
    local fileInfo = CCMaker.Data.FileManager[ job ]
    local msg

    if not fileInfo then
        msg = "[SERAPH] An internal error occurred while saving job data"
        return false, msg
    end

    local dataToSave = {}
    local shouldSaveEntry = fileInfo.shouldSaveEntry
    if shouldSaveEntry then
        local data = table.Copy( fileInfo.data() )
        for k,v in pairs( data ) do
            if shouldSaveEntry( v ) then
                v.Hardcoded = nil
                v.inLuaFile = nil
                table.insert( dataToSave, v )
            else
                print( "[SERAPH] SKIPING SAVE" )
                continue
            end
        end
    else
        dataToSave = fileInfo.data()
    end
    local saveDir = CCMaker.Data.SaveDir .. "/" .. "custom_jobs" .. "/" .. ply:SteamID64() .. ".txt"
    file.Write(saveDir, util.TableToJSON(dataToSave, true))

    return true
end
-- prepare file structures to receive data
hook.Add(
    "InitPostEntity",
    "yayo_CCMaker_PrepareData",
    function()
        CCMaker.PrepareData()
    end
)