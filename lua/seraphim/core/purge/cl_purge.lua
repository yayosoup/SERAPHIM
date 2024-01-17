net.Receive("updatePurgeStatus", function(len)
    round_status = net.ReadInt(8)

end)

function getPurgeStatus()
    return round_status
end
net.Receive("startClientPurge", function ()
    -- surface.PlaySound("kidneydagger/broadcast1.wav")
    chat.AddText(color_white, "A ", Color(255, 0 , 0), "PURGE", color_white, " has begun! All ", Color(255, 0 , 0), "CRIME", color_white, "is now legal!")
end)
net.Receive("tellPurgeVictor", function()
    local victor = net.ReadString()
    local count = net.ReadInt(4)

    chat.AddText(color_white, "The purge has ended!")
    chat.AddText(color_white, victor .. " had the highest kill count of: " .. count .. " kills!")
end)

net.Receive("noPurgeVictor", function()
    chat.AddText(color_white, "The purge has ended!")
    chat.AddText(color_white, "Nobody participated in the purge!")
end)