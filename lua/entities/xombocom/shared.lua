ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "zombocom"
ENT.Category = "yayoitems"
ENT.Spawnable = true

YAYO_MUTATIONS = YAYO_MUTATIONS or {}

YAYO_MUTATIONS.Mutations = {
    {
        name  = "Hot Head",
        price = 10,
        description = "When you take lethal headshot damage, explode and deal damage to nearby enemies.",
        func = function(ply)
            ply:ChatPrint("Hot Head mutation has been added to your character.")
        end
    },
    {
        name  = "This is a test name: I'm testing to see how it looks like when it's long",
        price = 10,
        description = "This is a test, i'm testing this to make sure it can fit a big description so i can see how it looks like because i am testing it",
        func = function(ply)
            ply:ChatPrint("Hot Head mutation has been added to your character.")
        end
    },
}   