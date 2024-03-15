print("sv_dopamine")
util.AddNetworkString("yayo_elimsound")
hook.Add(
    "PlayerDeath",
    "yayo_elimsound",
    function(vic, inf, atk)
        if atk:IsValid() and atk:IsPlayer() and vic:IsValid() and vic:IsPlayer() then
            net.Start("yayo_elimsound")
            net.WriteString(vic:Nick())
            net.Send(atk)
        end
    end
)

function DCONFIG2.AddCustomJob(job)
    PrintTable(job)
    if SERVER or CLIENT and DCONFIG2.CanDConfig(LocalPlayer()) then
        DCONFIG2.MsgC("Adding/Updating Custom Job " .. job.name)
    end

    local jobColor = job.color
    if jobColor then
        job.color = Color(jobColor.r, jobColor.g, jobColor.b, jobColor.a)
    end

    if job.customCheckString and SERVER then
        local check
        local errorMSG
        if job.customCheckString then
            check, errorMSG = CompileString("local ply = select(1,...) " .. job.customCheckString, "customCheck", false)
        end

        if type(check) == "function" then
            job.customCheck = check
        else
            DCONFIG2.MsgC("CUSTOM CHECK MISTAKE " .. check)

            return false
        end
    end

    if not DCONFIG2.IsValidCategory("jobs", job.category) then
        print("Creating category for ", job.category)
        dpcall(
            DarkRP.createCategory,
            {
                name = job.category,
                sortOrder = 100,
                categorises = "jobs",
                color = Color(0, 107, 0, 255),
                startExpanded = true,
                dconfig = true,
            }
        )
    end

    local onJobPlayers = {}
    local oldID = _G[job.jobvar]
    if SERVER then
        for k, ply in ipairs(player.GetAll()) do
            if ply:Team() == oldID then
                onJobPlayers[ply] = true
            end
        end
    end

    --TODO: Update entities, shipments, door groups, ammo, allowed with new IDS!!
    --print("SWAT:", TEAM_SWAT)
    local oldJobData = RPExtraTeams[oldID]
    if oldJobData then
        job.inLuaFile = oldJobData.inLuaFile
        job.teamKey = oldID
        DarkRP.removeJob(oldID)
        --print("REMOVING", job.jobvar, " OLD ", oldID)
    end

    local newID = dpcall(DarkRP.createJobDConfig, job.name, job)
    if (GM or GAMEMODE).DefaultTeam == oldID then
        (GM or GAMEMODE).DefaultTeam = newID
    end

    DCONFIG2.MsgC("[DEBUG]: SETTING " .. job.jobvar .. " to " .. newID)
    -- PrintTable(job)
    if not job.jobvar then
        DCONFIG2.MsgC("FAILED TO LOAD A JOB: " .. job.name or "Unknown Job", true)
        PrintTable(job)
    end

    _G[job.jobvar] = newID
    if SERVER then
        for ply, _ in pairs(onJobPlayers) do
            timer.Simple(
                0,
                function()
                    ply:SetTeam(-1)
                    ply:changeTeam(newID, true, false)
                end
            )
        end
    end

    if job.cp and not (GM or GAMEMODE).CivilProtection[newID] then
        (GM or GAMEMODE).CivilProtection[newID] = true
    end

    if job.hitman then
        dpcall(DarkRP.addHitmanTeam, newID)
    end

    if job.defaultTeam then
        (GM or GAMEMODE).DefaultTeam = newID
    end

    DCONFIG2.RefreshDefaultF4Menu()

    return true
end