ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "crafting_table"
ENT.Author = "yayo"
ENT.Contact = "yayosoup@gmail.com"
ENT.Purpose = "crafting_table"
ENT.Instructions = "crafting table for crafting items :3"
ENT.Category = "yayoitems"
ENT.Spawnable = true


function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "TechTrash")
    self:NetworkVar("Int", 1, "Metal")
    self:NetworkVar("Int", 2, "Wood")
    self:NetworkVar("Int", 3, "Chemical")
    self:NetworkVar("Int", 4, "Scrap")
    self:NetworkVar("Int", 5, "BloodBag")
end 