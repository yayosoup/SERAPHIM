local _P = FindMetaTable("Player")
function _P:GetCells()
    return self:GetNWInt("cells")
end