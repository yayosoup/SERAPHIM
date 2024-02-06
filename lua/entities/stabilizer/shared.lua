ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Stabilizer"
ENT.Spawnable = true
ENT.Author = "yayo"
ENT.Category = "yayoitems"

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "tech_trash")
end