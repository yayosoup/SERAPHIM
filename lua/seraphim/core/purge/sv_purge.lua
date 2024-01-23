print("sv_purge.lua started")

local purge_status = 0

util.AddNetworkString("updatePurgeStatus")
util.AddNetworkString("tellPurgeVictor")
util.AddNetworkString("noPurgeVictor")
util.AddNetworkString("startClientPurge")
util.AddNetworkString("startClientTiedPurge")
util.AddNetworkString("endClientPurge")
util.AddNetworkString("sendPurgeCheer")
util.AddNetworkString("PurgeStateChanged")



local function end_purge()
    net.Start("endClientPurge")
    net.Broadcast()

    net.Start("PurgeStateChanged")
        net.WriteBool(false)  -- Replace this with your actual purge state
    net.Broadcast()

    local highestKill = 0
    local highestKillPlayer
    local isTied = false
    local tiedPlayer

    for i,v in pairs(player.GetAll()) do
        local checkKill = v:GetNWInt("kills")
        if checkKill > highestKill then
            highestKill = checkKill
            highestKillPlayer = v
        elseif checkKill == highestKill then
            isTied = true
            tiedPlayer = v
        end
    end

    if highestKill == 0 then
        net.Start("noPurgeVictor")
        net.Broadcast()
    elseif isTied then
        sendVictor = highestKillPlayer:Nick()
        sendTied = tiedPlayer:Nick()
        net.Start("startClientTiedPurge")
            net.WriteString(sendVictor)
            net.WriteString(sendTied)
            net.WriteInt(highestKill, 4)
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

    net.Start("PurgeStateChanged")
        net.WriteBool(true)  -- Replace this with your actual purge state
    net.Broadcast()

    print("Starting the purge!!!")
    purge_status = 1

    for i,v in pairs(player.GetAll()) do
        v:SetNWInt("kills", 0)
    end

    timer.Stop("PurgeStarter")

    timer.Create("PurgeTimer", 10, 1, function()

        hook.Add("PlayerDeath", "killTracker", function(victim, inflictor, attacker)
            if victim == attacker then return end
            if attacker:IsPlayer() then
                attacker:SetNWInt("kills", attacker:GetNWInt("kills") + 1)
                net.Start("sendPurgeCheer")
                net.Send(attacker)
            end
        end)

        print("Ending the purge now!!!")
        end_purge()
        timer.Start("PurgeStarter")
    end)


end

local TIME_BETWEEN_PURGE = 5

timer.Create("PurgeStarter", TIME_BETWEEN_PURGE, 0, function()

    start_purge()
end)

function getPurgeStatus()

    return purge_status
end
