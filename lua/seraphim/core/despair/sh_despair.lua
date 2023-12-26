-- shared.lua

-- Constant for maximum despair value
MAX_DESPAIR = 100

-- Function to get a player's current despair level
function GetDespair(ply)
    return ply:getDarkRPVar("despair") or 0
end

function setDespair(ply, amn)
    ply:setDarkRPVar("despair", amn)
end