hook.Add(
    "DarkRPFinishedLoading",
    "sfloader",
    function()
        print("sf_loader has intialized!")
        -- REGISTER NEEDED VARIABLES DarkRP
        DarkRP.registerDarkRPVar("despair", net.WriteDouble, net.ReadDouble)
        DarkRP.registerDarkRPVar("salesTax", net.WriteDouble, net.ReadDouble)
        DarkRP.registerDarkRPVar("hasMission", net.WriteBool, net.ReadBool)
        -- sv_objective.lua
        DarkRP.registerDarkRPVar("currentMission", net.WriteString, net.ReadString)
        hook.Add(
            "PlayerInitialSpawn",
            "sv_objective",
            function(ply)
                ply:setDarkRPVar("hasMission", false)
            end
        )

        sf = sf or {}
        sf.Folders = {
            ["root"] = "seraphim/",
            ["core"] = "core/",
        }

        sf.Files = {
            {
                name = "sh_util",
                modulePath = "util/",
                type = "SHARED"
            },
            {
                name = "cl_util",
                modulePath = "util/",
                type = "CLIENT"
            },
            {
                name = "sh_despair",
                modulePath = "despair/",
                type = "SHARED"
            },

            {
                name = "sv_despair",
                modulePath = "despair/",
                type = "SERVER"
            },
            {
                name = "cl_despair",
                modulePath = "despair/",
                type = "CLIENT"
            },
            -- stabilizers mechinics to reduce despair, like drugs, alcohol, etc.
            {
                name = "sh_stabilizer",
                modulePath = "stabilizer/",
                type = "SHARED"
            },
            {
                name = "sv_stabilizer",
                modulePath = "stabilizer/",
                type = "SERVER"
            },
            {
                name = "cl_stabilizer",
                modulePath = "stabilizer/",
                type = "CLIENT"
            },
            -- still uses normal darkrp wanted system, but adds a few more features
            {
                name = "cl_wanted",
                modulePath = "wanted/",
                type = "CLIENT"
            },
            {
                name = "sv_wanted",
                modulePath = "wanted/",
                type = "SERVER"
            },
            {
                name = "sh_wanted",
                modulePath = "wanted/",
                type = "SHARED"
            },
            -- objective system, missions from god, gives players guidence on what to do. clears boredom *maybe*
            {
                name = "sv_objective",
                modulePath = "objective/",
                type = "SERVER"
            },
            {
                name = "sh_objective",
                modulePath = "objective/",
                type = "SHARED"
            },
            {
                name = "cl_objective",
                modulePath = "objective/",
                type = "CLIENT"
            },
            -- habit system, player spawns with a habit, habits are generally bad but they're basically a lifelong mission from god, not sure how to make it fun.
            {
                name = "sv_habits",
                modulePath = "habits/",
                type = "SERVER"
            },
            {
                name = "sh_habits",
                modulePath = "habits/",
                type = "SHARED"
            },
            {
                name = "cl_habits",
                modulePath = "habits/",
                type = "CLIENT"
            },
            -- purge system, 
            {
                name = "sv_purge",
                modulePath = "purge/",
                type = "SERVER"
            },
            {
                name = "sh_purge",
                modulePath = "purge/",
                type = "SHARED"
            },
            {
                name = "cl_purge",
                modulePath = "purge/",
                type = "CLIENT"
            },
            {
                name = "sv_cells",
                modulePath = "cells/",
                type = "SERVER"
            },
            {
                name = "cl_cells",
                modulePath = "cells/",
                type = "CLIENT"
            },
            {
                name = "sh_cells",
                modulePath = "cells/",
                type = "SHARED"
            },
            -- dopamine farmers, kill sound effects, etc.
            {
                name = "sv_dopamine",
                modulePath = "dopamine/",
                type = "SERVER"
            },
            {
                name = "cl_dopamine",
                modulePath = "dopamine/",
                type = "CLIENT"
            },
            -- on switch, tips for when players swap
            {
                name = "sv_onswitch",
                modulePath = "onSwitch/",
                type = "SERVER"
            },
            {
                name = "cl_onswitch",
                modulePath = "onSwitch/",
                type = "CLIENT"
            },
            {
                name = "sh_mutations_core",
                modulePath = "mutations/",
                type = "SHARED"
            },
            {
                name = "sv_mutations_player",
                modulePath = "mutations/",
                type = "SHARED"
            },
            {
                name = "sv_mutations_data",
                modulePath = "mutations/",
                type = "SERVER"
            },
            {
                name = "cl_mutations_core",
                modulePath = "mutations/",
                type = "CLIENT"
            },
            {
                name = "sv_mutations_core",
                modulePath = "mutations/",
                type = "SERVER"
            },
            {
                name = "cl_mutations_vgui",
                modulePath = "mutations/",
                type = "CLIENT"
            },
            {
                name = "sv_shape",
                modulePath = "skinshape/",
                type = "SERVER"
            },
            {
                name = "sh_shape",
                modulePath = "skinshape/",
                type = "SHARED"
            },
            {
                name = "cl_shape",
                modulePath = "skinshape/",
                type = "CLIENT"
            },
            {
                name = "sv_ccmaker_core",
                modulePath = "custom_jobs/",
                type = "SERVER"
            },
            {
                name = "sh_ccmaker_core",
                modulePath = "custom_jobs/",
                type = "SHARED"
            },
            {
                name = "sh_ccmaker_data",
                modulePath = "custom_jobs/",
                type = "SHARED"
            },
            {
                name = "sv_ccmaker_data",
                modulePath = "custom_jobs/",
                type = "SERVER"
            },
            {
                name = "cl_ccmaker_core",
                modulePath = "custom_jobs/",
                type = "CLIENT"
            },
            {
                name = "cl_ccmaker_frame",
                modulePath = "custom_jobs/",
                type = "CLIENT"
            },
            {
                name = "sv_crafting",
                modulePath = "crafting/",
                type = "SERVER"
            },
            {
                name = "sh_crafting",
                modulePath = "crafting/",
                type = "SHARED"
            },
            {
                name = "cl_crafting_core",
                modulePath = "crafting/",
                type = "CLIENT"
            },
            {
                name = "cl_crafting_frame",
                modulePath = "crafting/",
                type = "CLIENT"
            },
            {
                name = "cl_crafting_nav",
                modulePath = "crafting/",
                type = "CLIENT"
            },
            {
                name = "cl_crafting_body",
                modulePath = "crafting/",
                type = "CLIENT"
            },
            {
                name = "cl_crafting_scroll",
                modulePath = "crafting/",
                type = "CLIENT"
            },
            {
                name = "cl_crafting_recipe",
                modulePath = "crafting/",
                type = "CLIENT"
            },

        }

        function sf.Load()
            local root, core = sf.Folders["root"], sf.Folders["core"]
            for k, v in pairs(sf.Files) do
                v.name = v.name .. ".lua"
                if v.type == "SERVER" then
                    if SERVER then
                        include(root .. core .. v.modulePath .. v.name)
                    end
                elseif v.type == "SHARED" then
                    if SERVER then
                        AddCSLuaFile(root .. core .. v.modulePath .. v.name)
                        include(root .. core .. v.modulePath .. v.name)
                    else
                        include(root .. core .. v.modulePath .. v.name)
                    end
                elseif v.type == "CLIENT" then
                    if SERVER then
                        AddCSLuaFile(root .. core .. v.modulePath .. v.name)
                    else
                        include(root .. core .. v.modulePath .. v.name)
                    end
                end
            end
        end

        sf.Load()
    end
)