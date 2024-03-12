util.AddNetworkString("YAYO_MUTATION.PlayerJoined")
util.AddNetworkString("YAYO_MUTATION.PlayerPurchaseAttempt")
util.AddNetworkString("YAYO_MUTATION.PlayerPurchaseFailed")
util.AddNetworkString("YAYO_MUTATION.PlayerPurchaseSuccess")
util.AddNetworkString("YAYO_MUTATION.OpenMenu")
util.AddNetworkString("YAYO_MUTATION.ResetMutations")
util.AddNetworkString("YAYO_MUTATION.ResetMutationsSuccess")
util.AddNetworkString("YAYO_MUTATION.PlayerProcHothead")

net.Receive("YAYO_MUTATION.PlayerJoined", function(len, ply)
    if not IsValid(ply) then return end
    print("Player joined: " .. ply:Nick() )
    TEXT:LoadMutations( ply )

end)
--[[

hook.Add("Tick", "YAYO_MUTATION.SaveOnWrite", function()
    for _, ply in ipairs( player.GetAll() ) do
        if ply.NextMutationSave and ply.NextMutationSave < CurTime() then
            print("saving for: " .. ply:Nick() )
            TEXT:SaveMutations( ply )
        end
    end
end)

]]



net.Receive("YAYO_MUTATION.ResetMutations", function( len, ply )
    print("Player " .. ply:Nick() .. " is attempting to reset mutations")

    if ply:canAfford(1000000) then
        print("Player " .. ply:Nick() .. " passed mutation reset checks!")
        ply:addMoney(-1000000)
        TEXT:ResetMutations( ply )
        net.Start("YAYO_MUTATION.ResetMutationsSuccess")
        net.Send(ply)
    end
end)

hook.Add("PlayerSay", "YAYO_MUTATION.OpenMenu", function( ply, text )
    if string.lower(text) ~= string.lower("!mut") then return end
    net.Start("YAYO_MUTATION.OpenMenu")
    net.Send(ply)
end)

hook.Add("PlayerSay", "YAYO_MUTATION.DebugMoney", function( ply, text )
    if string.lower(text) ~= string.lower("!debugmoney") then return end
    ply:addMoney(1000000000)
end)

net.Receive("YAYO_MUTATION.PlayerPurchaseAttempt", function( len, ply )
    local mutation = net.ReadString()
    print(mutation)
    local mutCount = ply:GetNWInt("mutationCount")
    if YAYO_MUTATION.Catalog[mutation] && mutCount < 5 then
        print("Player " .. ply:Nick() .. " is attempting to purchase " .. mutation)
        if ply:canAffordCells( YAYO_MUTATION.Catalog[mutation].cells ) then
            ply:SetNWBool( YAYO_MUTATION.Catalog[mutation].bool, true )
            ply:SetNWInt( "mutationCount" , ply:GetNWInt("mutationCount") + 1)
            ply:RemoveCells( YAYO_MUTATION.Catalog[mutation].cells )
            net.Start("YAYO_MUTATION.PlayerPurchaseSuccess")
            net.Send(ply)
            TEXT:SaveMutations( ply )
        else
            print("Player " .. ply:Nick() .. " cannot afford " .. mutation)
            net.Start("YAYO_MUTATION.PlayerPurchaseFailed")
            net.Send(ply)
        end
    else
        print("Player " .. ply:Nick() .. " cannot purchase more than 5 mutations")
        net.Start("YAYO_MUTATION.PlayerPurchaseFailed")
        net.Send(ply)
    end
end)

-- -----------------------------------------------------------------------------------------------

local function CreateExplosion(inf, atk, org)
    util.BlastDamage(inf, atk, org, 300, 50)
    util.ScreenShake(org, 5, 5, 1, 300)

    local effectData = EffectData()
    effectData:SetStart(org)
    effectData:SetOrigin(org)
    effectData:SetScale(1)
    effectData:SetMagnitude(1)

    util.Effect("Explosion", effectData)
end

hook.Add("PlayerDeath", "YAYO_MUTATION.Hothead", function( vic, inf, atk)
    print("YAYO_MUTAITON.Hothead called!")
    if vic == atk then return end
    if inf:GetClass() == "worldspawn" then return end

    local hotHead = vic:GetNWBool("hasHotHead", false)
    if vic:LastHitGroup() == HITGROUP_HEAD && hotHead then
        net.Start("YAYO_MUTATION.PlayerProcHothead")
        net.Send(vic)
        net.Start("YAYO_MUTATION.PlayerProcHothead")
        net.Send(atk)

        local vicPos = vic:GetPos()
        vic:EmitSound("ambient/explosions/explode_" .. math.random(1, 9) .. ".wav", 75, 100, CHAN_VOICE)
        vic:EmitSound("placenta/head_explodie_0" .. math.random(1,4) .. ".ogg", 75, 100, CHAN_VOICE)
        print("placenta/head_explodie_0" .. math.random(1,4) .. ".ogg")
        CreateExplosion(inf, atk, vicPos)
    end
end)


concommand.Add("debugtool", function( ply )
    local dmginfo = DamageInfo()
    dmginfo:SetDamage(99)
    dmginfo:SetAttacker(game.GetWorld())
    dmginfo:SetDamageType( DMG_SHOCK )

    timer.Create("ShockDamageTimer", 1, 5, function()
        if IsValid(ply) then
            print("Player is taking damage!")
            ply:TakeDamageInfo(dmginfo)
        else
            timer.Remove("ShockDamageTimer")
        end
    end)
end)













concommand.Add("checkMutations", function ( ply )
    TEXT:PrintMutations(ply)
end)

hook.Add("PlayerButtonDown", "GiveWeaponOnBPress", function(ply, button)
    if button == KEY_B and ply:Team() == TEAM_SKINSHAPE then
        ply:Give("weapon_dishonored_shadowwalk")
        ply:SelectWeapon("weapon_dishonored_shadowwalk")

        timer.Simple(10, function()
            if IsValid(ply) then
                ply:SelectWeapon("weapon_physcannon")
            end
        end)
    end
end)