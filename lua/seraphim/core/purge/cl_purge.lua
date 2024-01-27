surface.CreateFont( "FINALS", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 45,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
} )
surface.CreateFont( "finalsSubtitle", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 95,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
} )


net.Receive("updatePurgeStatus", function(len)
    round_status = net.ReadInt(8)

end)

function getPurgeStatus()
    return round_status
end
net.Receive("startClientPurge", function ()
    -- surface.PlaySound("kidneydagger/broadcast1.wav")
    chat.AddText(color_white, "A ", Color(255, 0 , 0), "PURGE", color_white, " has begun! All ", Color(255, 0 , 0), "CRIME", color_white, "is now legal!")

    local x = 2
    local alphaEvent = 0
    local alphaActive = 0
    hook.Add("HUDPaint", "PurgeTimer", function()
        draw.SimpleText("ACTIVE", "FINALS", ScrW() / 2, ScrH() / 7, Color(255, 255, 255, alphaActive), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("PURGE", "finalsSubtitle", ScrW() / 2, ScrH() / x, Color(210, 31, 60, alphaEvent), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if alphaEvent < 255 then
            alphaEvent = alphaEvent + 0.25
        end
        if alphaEvent == 255 and x < 5.5 then
            x = x + 2 * FrameTime()
        end
        if x >= 5.5 then
            alphaActive = alphaActive + 0.5
        end
    end)


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

net.Receive("startClientTiedPurge", function()
    local victor = net.ReadString()
    local tiedVictor = net.ReadString()
    local count = net.ReadInt(4)

    chat.AddText(color_white, victor .. " and " .. tiedVictor .. " haved tied. With the highest kill count of: " .. count .. " kills!")

end)

local function cleanup_purgehud()
    hook.Remove("HUDPaint", "PurgeTimer")
end

net.Receive("endClientPurge", function()
    print(" end client purge! ")
    cleanup_purgehud()
end)

net.Receive("sendPurgeCheer", function()
    surface.PlaySound("kidneydagger/radio.wav")
end)

local dist = 4000^2
hook.Add("HUDPaint", "BloodESP", function()
    if LocalPlayer():Team() != TEAM_BLOOD then return end

    local bloodPlayers = {}

    for _, ply in ipairs(player.GetAll()) do
        if ply:Team() == TEAM_BLOOD then
            table.insert(bloodPlayers, ply)
        end
    end


    for k,v in ipairs(bloodPlayers) do
        local pos = v:GetPos()
        if LocalPlayer():GetPos():DistToSqr(pos) < dist then
            pos = pos:ToScreen()
            surface.SetDrawColor(0, 0, 0, 200)
            surface.DrawRect(pos.x - 32, pos.y, -32,64,64)
            draw.SimpleText(v:Name(), Default, pos.x, pos.y, Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Bloods Teammate:", Default, pos.x, pos.y - 10, Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end)
