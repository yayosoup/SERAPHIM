net.Receive("mission", function()
    local missions = net.ReadTable()
    chat.AddText("New Mission: " .. missions.name .. " - " .. missions.desc)
end)