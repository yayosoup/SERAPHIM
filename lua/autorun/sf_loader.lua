print("sf_loader has intialized!")

sf = sf or {}

sf.Folders = {
    [ "root" ] = "seraphim/",
    [ "core" ] = "core/",
}

sf.Files = {
    { name = "sv_despair", modulePath = "despair/", type = "SERVER" },
    { name = "sh_despair", modulePath = "despair/", type = "SHARED" },
    { name = "cl_despair", modulePath = "despair/", type = "CLIENT" },
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
        end
    end
end
-- Couldn't include file 'seraphim_framework/seraphim/core/habits/sv_habits.lua' - File not found or is empty
-- seraphim_framework/seraphim/core/habits/
sf.Load()
