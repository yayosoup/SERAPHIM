CCMaker.Data = {
    SaveDir = "seraphim",
    SubFolders = {
        ["custom_jobs"] = true,
    },
    FileManager = {
        jobs = {
            data = function() return RPExtraTeams end,
            loadEntry = CCMaker.AddCustomJob,
            shouldLoadEntry = function( dataEntry )
                if not dataEntry.jobvar then return false end

                return true
            end,
            shouldSaveEntry = function ( dataEntry )
                if dataEntry.shouldReset then return false end

                return true
            end,
        }
    }
}