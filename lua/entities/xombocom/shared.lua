ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "zombocom"
ENT.Category = "yayoitems"
ENT.Spawnable = true

YAYO_MUTATIONS = YAYO_MUTATIONS or {}

YAYO_MUTATIONS.Mutations = {
    {
        name  = "Hot Head",
        cells_price = 10,
        description = "When you take lethal headshot damage, explode and deal damage to nearby enemies.",
        func = function(ply)
            ply:ChatPrint("Hot Head mutation has been added to your character.")
        end
    }
}