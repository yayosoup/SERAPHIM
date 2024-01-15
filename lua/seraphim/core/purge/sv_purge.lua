print("sv_purge.lua started")

local purge_status = 0

util.AddNetworkString("updatePurgeStatus")

local function end_purge()

    purge_status = 0
    updatePurgeClient()
end

function start_purge()
    print("Starting the purge!!!")
    purge_status = 1



    timer.Create("PurgeTimer", 5, 1, function()
        hook.Add("PlayerDeath", "Kill Tracker", function(victim, inflictor, attacker)
            if victim == attacker then return end
            if attacker:IsPlayer() then
                attacker:SetNWInt("kills", attacker:GetNWInt("kills") + 1)
            end
        end)

        print("Ending the purge now!!!")
        end_purge()
    end)

end

function updatePurgeClient()
    net.Start("updatePurgeStatus")
        net.WriteInt(purge_status, 4)
    net.Broadcast()
end

timer.Create("PurgeStarter", 15, 0, function()
    start_purge()
end)














function getPurgeStatus()

    return purge_status
end