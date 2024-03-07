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

timer.Create("DespairIncrementTimer", 120, 0, IncrementDespair)

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

local healingDelay = 7
local healingRate = 25

hook.Add("PlayerHurt", "StartHealingTimer", function(ply, attacker, remainingHealth, damageTaken)
    if remainingHealth <= ply:GetMaxHealth() * 0.25 then
        local timerName = "HealingTimer_" .. ply:SteamID()
        if timer.Exists(timerName) then
            timer.Remove(timerName)
        end
        timer.Create(timerName, healingDelay, 0, function()
            if IsValid(ply) and ply:Alive() and ply:Health() < ply:GetMaxHealth() * .50 then
                ply:SetHealth(math.min(ply:GetMaxHealth(), ply:Health() + healingRate))
            else
                timer.Remove(timerName)
            end
        end)
    end
end)

hook.Add("PlayerDeath", "StopHealingTimer", function(ply)
    local timerName = "HealingTimer_" .. ply:SteamID()
    if timer.Exists(timerName) then
        timer.Remove(timerName)
    end
end)