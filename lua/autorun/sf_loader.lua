hook.Add("DarkRPFinishedLoading", "sfloader", function()
    print("sf_loader has intialized!")

    -- REGISTER NEEDED VARIABLES :D
    DarkRP.registerDarkRPVar("despair", net.WriteDouble, net.ReadDouble)


    sf = sf or {}

    sf.Folders = {
        [ "root" ] = "seraphim/",
        [ "core" ] = "core/",
    }

    sf.Files = {
        { name = "sh_despair", modulePath = "despair/", type = "SHARED" },
        { name = "sv_despair", modulePath = "despair/", type = "SERVER" },
        { name = "cl_despair", modulePath = "despair/", type = "CLIENT" },
        { name = "cl_wanted", modulePath = "wanted/", type = "CLIENT" },
        { name = "sv_wanted", modulePath = "wanted/", type = "SERVER" },
        { name = "sh_wanted", modulePath = "wanted/", type = "SHARED" },
    }

    function sf.Load()
        print("sf.Load has intialized!")
        local root, core = sf.Folders[ "root" ], sf.Folders[ "core" ]
        for k, v in pairs( sf.Files ) do
            v.name = v.name .. ".lua"
            if v.type == "SERVER" then
                if SERVER then include( root .. core .. v.modulePath .. v.name ) end
            elseif v.type == "SHARED" then
                if SERVER then include ( root .. core .. v.modulePath .. v.name ) end
            elseif v.type == "CLIENT" then
                if SERVER then AddCSLuaFile( root .. core .. v.modulePath .. v.name )
                else include( root .. core .. v.modulePath .. v.name ) end
            end
        end
    end

    sf.Load()


end)