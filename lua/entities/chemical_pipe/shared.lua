ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "chemical_pipe"
ENT.Author = "yayo"
ENT.Contact = "yayosoup@gmail.com"
ENT.Purpose = "chemical_pipe"
ENT.Instructions = "base npc entity"
ENT.Category = "yayoitems"
ENT.Spawnable = true


function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "isAlive")
    self:NetworkVar("Bool", 1, "isOilFilling")

    self:NetworkVar("Bool", 2, "isFilling")
    self:NetworkVar("Int", 1, "HealthPipe")
end