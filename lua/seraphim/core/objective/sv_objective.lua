print("sv_objective init!")
local missions = {
    ["Massacre"] = {
        name = "Massacre",
        desc = "kill 3 people",
        isComplete = function(ply)
            hook.Add("PlayerKilled", "CheckMassacre", function(victim, inflictor, attacker)
                if attacker == ply then
                    ply:setDarkRPVar("massacreMission", ply:getDarkRPVar("massacreMission") + 1)
                end
            end)
        end
    }
    -- ...
}
function assignMission(ply)
    local mission = table.Random(missions)
    if mission then
        ply:setDarkRPVar("currentMission", mission.name)
    end
end

timer.Create("CheckMissionStatus", 2, 0, function()
    print("Checking mission status...")
    for _, ply in ipairs(player.GetAll()) do
        local hasMission = ply:getDarkRPVar("hasMission")
        if hasMission then
             local missionName = ply:getDarkRPVar("currentMission")
            print("Player " .. ply:Nick() .. " has a mission. The mission is: " .. missionName)
        elseif hasMission == false then
            print("Player " .. ply:Nick() .. " has no mission, giving one.")
            assignMission(ply)
            ply:setDarkRPVar("hasMission", true)
        end
    end
end)
