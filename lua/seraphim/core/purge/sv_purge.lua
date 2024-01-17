print("sv_purge.lua started")

local purge_status = 0

util.AddNetworkString("updatePurgeStatus")
util.AddNetworkString("tellPurgeVictor")
util.AddNetworkString("noPurgeVictor")
util.AddNetworkString("startClientPurge")


local function end_purge()

    local highestKill = 0
    local highestKillPlayer

    for i,v in pairs(player.GetAll()) do
        local checkKill = v:GetNWInt("kills")
        if checkKill > highestKill then
            highestKill = checkKill
            highestKillPlayer = v
        end
    end

    if highestKill == 0 then
        net.Start("noPurgeVictor")
        net.Broadcast()
    else
        sendVictor = highestKillPlayer:Nick()
        net.Start("tellPurgeVictor")
            net.WriteString(sendVictor)
            net.WriteInt(highestKill, 4)
        net.Broadcast()
    end


    purge_status = 0
end

function start_purge()
    net.Start("startClientPurge")
    net.Broadcast()

    print("Starting the purge!!!")
    purge_status = 1

    for i,v in pairs(player.GetAll()) do
        v:SetNWInt("kills", 0)
    end


    timer.Create("PurgeTimer", 30, 1, function()

        hook.Add("PlayerDeath", "Kill Tracker", function(victim, inflictor, attacker)
            if victim == attacker then return end
            if attacker:IsPlayer() then
                -- TODO: idk idk seems shit 
                attacker:SetNWInt("kills", attacker:GetNWInt("kills") + 1)
            end
        end)

        print("Ending the purge now!!!")
        end_purge()
    end)

end

local TIME_BETWEEN_PURGE = 15

timer.Create("PurgeStarter", TIME_BETWEEN_PURGE, 0, function()
    if TIME_BETWEEN_PURGE == 3 then
        timer.Create("CountdownToOne", 1, 3, function()
            local countdown = 3 - timer.RepsLeft("CountdownToOne") + 1
            chat.AddText(countdown .. "...")
        end)
    end
    start_purge()
end)








function getPurgeStatus()

    return purge_status
end