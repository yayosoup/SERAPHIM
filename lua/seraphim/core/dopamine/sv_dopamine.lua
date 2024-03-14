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

