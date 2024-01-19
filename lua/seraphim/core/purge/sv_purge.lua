print("sv_purge.lua started")

local purge_status = 0

util.AddNetworkString("updatePurgeStatus")
util.AddNetworkString("tellPurgeVictor")
util.AddNetworkString("noPurgeVictor")
util.AddNetworkString("startClientPurge")
util.AddNetworkString("startClientTiedPurge")
util.AddNetworkString("endClientPurge")
util.AddNetworkString("sendPurgeCheer")


local function end_purge()
    net.Start("endClientPurge")
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

    print("Starting the purge!!!")
    purge_status = 1

    for i,v in pairs(player.GetAll()) do
        v:SetNWInt("kills", 0)
    end

    timer.Stop("PurgeStarter")

    timer.Create("PurgeTimer", 10, 1, function()

        hook.Add("PlayerDeath", "Kill Tracker", function(victim, inflictor, attacker)
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


combinespawn = {
    Vector(-837.260742, 582.187561, -117.628250),
    Vector(-856.291260, 776.911987, -117.628250),
    Vector(-598.566406, 641.718933, -119.026413),
    Vector(-422.228577, 1862.008789, 124.031250),
    Vector(-54.562851, 1618.202881, 124.031250),
    Vector(-632.736694, 1430.559570, 124.031250),
}

rebelspawn = {
    Vector(-653.948242, 1003.909729, 124.031250),
    Vector(-65.267960, 996.894775, 124.031250),
    Vector(-120.267349, 560.083435, -139.968750),
    Vector(-206.198029, 896.266113, -131.968750)
}

timer.Create("CombineSpawn", 5, 0, function()

    for i,v in pairs(combinespawn) do
        local combine = ents.Create("npc_combine_s")
        combine:SetPos(v)
        combine:Spawn()
        combine:Give("weapon_ar2")
        combine:SetKeyValue("additionalequipment", "weapon_ar2")
        combine:Fire("SetParentAttachment", "anim_attachment_RH")
        combine:Fire("SetParent", "player")
        combine:Fire("SetParentAttachmentMaintainOffset", "anim_attachment_RH")
        combine:Spawn()
    end
end)
timer.Create("RebelSpawn", 5, 0, function()

    for i,v in pairs(rebelspawn) do
        local rebel = ents.Create("npc_citizen")
        rebel:SetPos(v)
        rebel:Spawn()
        rebel:Give("weapon_rpg")
        rebel:SetKeyValue("additionalequipment", "weapon_rpg")
        rebel:Fire("SetParentAttachment", "anim_attachment_RH")
        rebel:Fire("SetParent", "player")
        rebel:Fire("SetParentAttachmentMaintainOffset", "anim_attachment_RH")
        rebel:Spawn()
    end
end)