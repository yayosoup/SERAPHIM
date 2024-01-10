print("sv_objective init!")

util.AddNetworkString("startQuest")

local missions = {
    ["Massacre"] = {
        name = "Massacre",
        desc = "Kill 3 people",
        isComplete = function(ply)
            local checkKills = ply:GetNWInt("killCount")
            return checkKills >= 3
        end
    }
}

function assignMission(ply)
    local mission = table.Random(missions)
    if mission then
        ply:setDarkRPVar("currentMission", mission.name)
        ply:loadKillCount()
    end
end

timer.Create("CheckMissionStatus", 50, 0, function()
    print("Checking mission status...")
    for _, ply in ipairs(player.GetAll()) do
        local hasMission = ply:getDarkRPVar("hasMission")
        if hasMission then
            local missionName = ply:getDarkRPVar("currentMission")
            print("Player " .. ply:Nick() .. " has a mission. The mission is: " .. missionName)
        elseif hasMission == false or hasMission == nil then
            print("Player " .. ply:Nick() .. " has no mission, giving one.")
            assignMission(ply)
            local missionName = ply:getDarkRPVar("currentMission")
            print("player " .. ply:Nick() .. " has been given the mission " .. missionName)
            ply:setDarkRPVar("hasMission", true)

            net.Start("startQuest")
                net.WriteString(missionName)
                net.WriteString(missions[missionName].desc)
            net.Send(ply)
        end
    end
end)

hook.Add("PlayerDeath", "CheckMassacre", function(victim, inflictor, attacker)
    if attacker != victim and attacker:getDarkRPVar("currentMission") == "Massacre" then
        local checkKills = attacker:GetNWInt("killCount") or 0
        checkKills = checkKills + 1
        print(checkKills)
        attacker:SetNWInt("killCount", checkKills)
        print(attacker:Nick() .. " has " .. checkKills .. " kills")
        if missions["Massacre"].isComplete(attacker) then
            print("Player " .. attacker:Nick() .. " has completed the mission ")
            attacker:setDarkRPVar("hasMission", false)
        end
    end
end)