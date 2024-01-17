local purge_status = 0

net.Receive("updatePurgeStatus", function(len)
    round_status = net.ReadInt(8)

end)

function getPurgeStatus()
    return round_status
end

net.Receive("tellPurgeVictor", function()
    local victor = net.ReadEntity()
    local count = net.ReadInt(8)

    chat.AddText(color_white, victor .. " had the highest kill count of: " .. count .. " kills!")
end)