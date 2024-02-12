print("sv_wanted.lua loaded!")

hook.Add("PlayerWanted", "UpdateWantedStatus", function(criminal, actor, reason)
    -- Broadcast the wanted status and reason to all clients
    net.Start("UpdateWantedStatus")
    net.WriteBool(true)
    net.WriteString(reason)
    net.Send(criminal)

    -- Play the siren sound on all clients
    BroadcastLua('surface.PlaySound("ambient/alarms/city_warning_siren1.wav")')
    print("Player " .. criminal:Nick() .. " is wanted for " .. reason .. " by " .. actor:Nick() .. " Play sound NOW!!!")
end)