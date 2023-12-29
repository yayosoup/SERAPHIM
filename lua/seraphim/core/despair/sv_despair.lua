local function IncrementDespair()
    for _, ply in ipairs(player.GetAll()) do
        local currentDespair = ply:getDarkRPVar("despair") or 0
        if currentDespair < MAX_DESPAIR then
            ply:setDarkRPVar("despair", currentDespair + 10)
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

local function AnnounceDespair()
    for _, ply in ipairs(player.GetAll()) do
        local despairLevel = ply:getDarkRPVar("despair") or 0
        ply:Say("My despair is: " .. despairLevel)
    end
end

timer.Create("AnnounceDespairTimer", 5, 0, AnnounceDespair)

hook.Add("PlayerDeath", "ResetDespair", function(ply)
    ply:setDarkRPVar("despair", 0)
end)