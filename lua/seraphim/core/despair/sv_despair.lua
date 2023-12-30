util.AddNetworkString("UpdateDespair")

local function IncrementDespair()
    for _, ply in ipairs(player.GetAll()) do
        local currentDespair = ply:getDarkRPVar("despair") or 0
        if currentDespair < MAX_DESPAIR then
            ply:setDarkRPVar("despair", currentDespair + 1)
            net.Start("UpdateDespair")
            net.WriteInt(currentDespair + 10, 32)
            net.Send(ply)
        end
    end
end

timer.Create("DespairIncrementTimer", 2, 0, IncrementDespair)

hook.Add("Think", "DespairDeathCheck", function()
    for _, ply in ipairs(player.GetAll()) do
        local currentDespair = ply:getDarkRPVar("despair") or 0
        if currentDespair >= MAX_DESPAIR then
            ply:Kill()
            ply:setDarkRPVar("despair", 0)
        end
    end
end)

hook.Add("PlayerDeath", "ResetDespair", function(ply)
    ply:setDarkRPVar("despair", 0)
    net.Start("UpdateDespair")
    net.WriteInt(0, 32)
    net.Send(ply)
end)