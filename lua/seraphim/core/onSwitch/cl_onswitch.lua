net.Receive("yayo_crusaderAppeared", function()
    chat.AddText(Color(0, 0, 0, 255), "OCCULT", Color(50, 50, 50, 255), "|", color_white, " A Crusader has breached the veil.")
    surface.PlaySound("placenta/radiokom2.wav")
end)
net.Receive("yayo_crusaderCooldown", function()
    chat.AddText(Color(0, 0, 0, 255), "OCCULT", Color(50, 50, 50, 255), "|", color_white, " A Crusader Potential has appeared!.")
end)
net.Receive("yayo_martyrCooldown", function()
    chat.AddText(Color(0, 0, 0, 255), "OCCULT", Color(50, 50, 50, 255), "|", color_white, " A Martyr Potential has appeared!.")
end)

local function cleanupWaypoint()
    hook.Remove("HUDPaint", "Waypoint")
end

local function DrawWaypoint(vector, location)
    print("Drawing waypoint")
    local dist = 1500^2
    hook.Add("HUDPaint", "Waypoint", function()
        if LocalPlayer():GetPos():DistToSqr(vector) > dist then
            local screenPos = vector:ToScreen()
            draw.SimpleText(location, "SeraphimFinalsSub", screenPos.x, screenPos.y, Color( 200, 56, 56 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            cleanupWaypoint()
        end
    end)
end

net.Receive("yayo_crusaderHUD", function()
    local vector = Vector(-1685.119019, -60, -160.968750)
    local location = "Bomb Site"
    DrawWaypoint(vector, location)
end)