include("shared.lua")

local zomboPanel = nil

function ENT:Draw()
    self:DrawModel()
end

net.Receive("zomboStart", function(len, ply)
    if IsValid(mayorPanel) then return end
    local cells = net.ReadInt(32)
    YAYO_MUTATIONS.Open(cells)
end)
