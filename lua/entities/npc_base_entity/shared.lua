ENT.Base = "base_entity"
ENT.Type = "ai"

ENT.PrintName = "npc_base_entity"
ENT.Author = "yayo"
ENT.Contact = "yayosoup@gmail.com"
ENT.Purpose = "base npc entity"
ENT.Instructions = "base npc entity"
ENT.Category = "yayoitems"
ENT.Spawnable = true

ENT.AutomaticFrameAdvance = false

function ENT:OnRemove()
    print(self:GetClass() .. " has been removed!")
end