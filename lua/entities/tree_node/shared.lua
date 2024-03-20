ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "tree_nude"
ENT.Author = "yayo"
ENT.Contact = "yayosoup@gmail.com"
ENT.Purpose = "tree_nude"
ENT.Instructions = "base npc entity"
ENT.Category = "yayoitems"
ENT.Spawnable = true


function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "isAlive")
    self:NetworkVar("Int", 1, "HealthPipe")
end