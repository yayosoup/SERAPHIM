local flashColor = Color(255, 0, 0)
local flashSpeed = 2

hook.Add("HUDPaint", "DrawWantedStatus", function()
    local ply = LocalPlayer()
    if ply:isWanted() then
        local wantedReason = ply:getDarkRPVar("wantedReason") or "No reason given"
        local wantedTime = ply:getDarkRPVar("wantedTime") or 0
        local timeLeft = math.max(0, wantedTime - CurTime())

        -- Flash between red and blue
        flashColor.r = math.sin(CurTime() * flashSpeed) * 127 + 128
        flashColor.b = math.sin(CurTime() * flashSpeed + math.pi) * 127 + 128

        draw.SimpleTextOutlined("REASON: " .. wantedReason .. " TIME LEFT: " .. string.ToMinutesSeconds(timeLeft), "Default", ScrW() / 2, ScrH() - 50, flashColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
    end
end)