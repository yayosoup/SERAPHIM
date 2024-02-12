--[[

net.Receive("startQuest", function()
    local missions = net.ReadTable()
    chat.AddText("New Mission: " .. missions.name .. " - " .. missions.desc)
end)
--]]

print("cl_objective.lua loaded")

-- TODO: Make this look more pretty!

net.Receive("startQuest", function()
    print("startQuest received")
    local mission = net.ReadString()
    local desc = net.ReadString()
    --surface.PlaySound("garrysmod/save_load2.wav")
    chat.AddText(Color(0, 255, 0), "MISSION FROM GOD!")
    chat.AddText(Color(0, 255, 0), "[4 CELLS] ", Color(0,255,0), desc)
end)