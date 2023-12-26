-- Function to increment despair
local function IncrementDespair()
    for _, ply in ipairs(player.GetAll()) do
        local currentDespair = GetDespair(ply)
        if currentDespair < MAX_DESPAIR then
            ply:setDarkRPVar("despair", currentDespair + 10)
        end
    end
end

-- Set up the timer for incrementing despair
timer.Create("DespairIncrementTimer", 2, 0, IncrementDespair)

-- Think hook for immediate condition checks
hook.Add("Think", "DespairDeathCheck", function()
    for _, ply in ipairs(player.GetAll()) do
        if GetDespair(ply) >= MAX_DESPAIR then
            ply:Kill()
            ply:setDarkRPVar("despair", 0)
        end
    end
end)

local function AnnounceDespair()
    for _, ply in ipairs(player.GetAll()) do
        local despairLevel = GetDespair(ply)
        ply:Say("My despair is: " .. despairLevel)
    end
end

-- Create a timer that calls AnnounceDespair every 5 seconds
timer.Create("AnnounceDespairTimer", 5, 0, AnnounceDespair)

hook.Add("PlayerDeath", "ResetDespair", function(ply)
    ply:setDarkRPVar("despair", 0)
end)