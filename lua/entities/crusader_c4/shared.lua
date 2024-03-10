ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "crusader_c4"
ENT.Author = "yayo"
ENT.Contact = "yayosoup@gmail.com"
ENT.Purpose = "crusader_c4"
ENT.Instructions = "base npc entity"
ENT.Category = "yayoitems"
ENT.Spawnable = true


function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "bombPlanted")
end