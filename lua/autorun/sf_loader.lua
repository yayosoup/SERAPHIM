AddCSLuaFile("imgui.lua")
hook.Add("DarkRPFinishedLoading", "sfloader", function()
    AddCSLuaFile("imgui.lua")
    imgui = include("imgui.lua")
    print("sf_loader has intialized!")

    -- REGISTER NEEDED VARIABLES DarkRP
    DarkRP.registerDarkRPVar("despair", net.WriteDouble, net.ReadDouble)
    DarkRP.registerDarkRPVar("salesTax", net.WriteDouble, net.ReadDouble)
    DarkRP.registerDarkRPVar("hasMission", net.WriteBool, net.ReadBool)

    -- sv_objective.lua
    DarkRP.registerDarkRPVar("currentMission", net.WriteString, net.ReadString)


    hook.Add("PlayerInitialSpawn", "sv_objective", function(ply)
        ply:setDarkRPVar("hasMission", false)
    end)



    sf = sf or {}

    sf.Folders = {
        [ "root" ] = "seraphim/",
        [ "core" ] = "core/",
    }

    sf.Files = {
        -- despair mechanics, like a reverse health system, reach 100 and you die. various activities remove/give despair.
        { name = "sh_despair", modulePath = "despair/", type = "SHARED" },
        { name = "sv_despair", modulePath = "despair/", type = "SERVER" },
        { name = "cl_despair", modulePath = "despair/", type = "CLIENT" },
        -- stabilizers mechinics to reduce despair, like drugs, alcohol, etc.
        { name = "sh_stabilizers", modulePath = "stabilizers/", type = "SHARED" },
        { name = "sv_stabilizers", modulePath = "stabilizers/", type = "SERVER" },
        { name = "cl_stabilizers", modulePath = "stabilizers/", type = "CLIENT" },
        -- still uses normal darkrp wanted system, but adds a few more features
        { name = "cl_wanted", modulePath = "wanted/", type = "CLIENT" },
        { name = "sv_wanted", modulePath = "wanted/", type = "SERVER" },
        { name = "sh_wanted", modulePath = "wanted/", type = "SHARED" },
        -- objective system, missions from god, gives players guidence on what to do. clears boredom *maybe*
        { name = "sv_objective", modulePath = "objective/", type = "SERVER" },
        { name = "sh_objective", modulePath = "objective/", type = "SHARED" },
        { name = "cl_objective", modulePath = "objective/", type = "CLIENT" },
        -- habit system, player spawns with a habit, habits are generally bad but they're basically a lifelong mission from god, not sure how to make it fun.
        { name = "sv_habits", modulePath = "habits/", type = "SERVER" },
        { name = "sh_habits", modulePath = "habits/", type = "SHARED" },
        { name = "cl_habits", modulePath = "habits/", type = "CLIENT" },
        -- purge system, 
        { name = "sv_purge", modulePath = "purge/", type = "SERVER" },
        { name = "sh_purge", modulePath = "purge/", type = "SHARED" },
        { name = "cl_purge", modulePath = "purge/", type = "CLIENT" },
        { name = "sv_cells", modulePath = "cells/", type = "SERVER" },
        { name = "cl_cells", modulePath = "cells/", type = "CLIENT" },
        -- dopamine farmers, kill sound effects, etc.
        { name = "sv_dopamine", modulePath = "dopamine/", type = "SERVER" },
        { name = "cl_dopamine", modulePath = "dopamine/", type = "CLIENT" },
        -- on switch, tips for when players swap
        { name = "sv_onswitch", modulePath = "onSwitch/", type = "SERVER" },
        { name = "cl_onswitch", modulePath = "onSwitch/", type = "CLIENT" },
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

