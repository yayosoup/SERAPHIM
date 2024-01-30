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
util.AddNetworkString("PurgeStarting")
util.AddNetworkString("tellPurgeModel")


local function check_victors()

end
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
        print(v:Nick() .. " has " .. checkKill .. " kills")
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
        victorModel = highestKillPlayer:GetModel()
        net.Start("tellPurgeVictor")
            net.WriteString(sendVictor)
            net.WriteInt(highestKill, 4)
        net.Broadcast()
        net.Start("tellPurgeModel")
            net.WriteString(victorModel)
        net.Broadcast()
    end


    purge_status = 0
end


function start_purge()
    purge_status = 1
    net.Start("startClientPurge")
    net.Broadcast()

    net.Start("PurgeStateChanged")
        net.WriteBool(true)
    net.Broadcast()

    print("Starting the purge!!!")

    for i,v in pairs(player.GetAll()) do
        v:SetNWInt("kills", 0)
    end

    timer.Stop("PurgeStarter")

    local PURGE_DURATION = 45
    local PURGE_INIT = 10
    timer.Create("PurgeTimer", PURGE_INIT, 1, function()

        timer.Simple(PURGE_DURATION, function()
            end_purge()
            print("Ending the purge now!!!")
            timer.Start("PurgeStarter")
        end)
    end)
end

hook.Add("PlayerDeath", "killTracker", function(victim, inflictor, attacker)
    print("Kill tracker called " .. purge_status)
    if (purge_status == 1 and victim:IsPlayer() and attacker:IsPlayer() and victim != attacker) then
        print("kill tracked successfuly from " .. attacker:Nick())
        attacker:SetNWInt("kills", attacker:GetNWInt("kills") + 1)
        print(attacker:GetNWInt("kills"))
        net.Start("sendPurgeCheer")
        net.Send(attacker)
    end
end)

local TIME_BETWEEN_PURGE = 30

timer.Create("PurgeStarter", TIME_BETWEEN_PURGE, 0, function()

    start_purge()
end)

function getPurgeStatus()

    return purge_status
end

/*
for k,v in pairs(player.GetAll()) do
    if v:Team() == TEAM_HITMAN then
       print("Hitman found" .. v:Nick())
    else
        print("Hitman not found")
    end
end

hook.Add( "PlayerShouldTakeDamage", "AntiTeamkill", function( ply, attacker )
    if ply:Team() == TEAM_BLOOD and attacker:Team() == TEAM_BLOOD then
        print (ply:Nick() .. " tried to kill " .. attacker:Nick())
        return false
    end
end )
*/
local function explode(inf, atk, org)
    util.BlastDamage(inf, atk, org, 300, 50)
    util.ScreenShake(org, 5, 5, 1, 300)

    local effectData = EffectData()
    effectData:SetStart(org)
    effectData:SetOrigin(org)
    effectData:SetScale(1)
    effectData:SetMagnitude(1)

    util.Effect("Explosion", effectData)
end

hook.Add("PlayerDeath", "DeadGoBoom", function(vic, inf, atk)
    if vic == atk then return end
    if inf:GetClass() == "worldspawn" then return end
    local vicPos = vic:GetPos()
    vic:EmitSound("ambient/explosions/explode_" .. math.random(1, 9) .. ".wav", 75, 75, CHAN_VOICE)
    explode(inf, atk, vicPos)
end)
