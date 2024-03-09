-- Initialize a variable to control the fade effect
local alpha = 0
local start_time = nil
local image = Material("mutations/blackmage.png")

net.Receive("YAYO_MUTATION.PlayerProcHothead", function()
    start_time = CurTime()
end)

hook.Add("HUDPaint", "YAYO_MUTATION.PlayerProcedHothead", function()
    if start_time then
        local elapsed_time = CurTime() - start_time
        if elapsed_time < 1 then
            alpha = math.sin(elapsed_time * math.pi / 2)
        elseif elapsed_time < 3 then
            alpha = 1
        elseif elapsed_time < 4 then
            alpha = math.cos((elapsed_time - 3) * math.pi / 2)
        else
            return
        end

        surface.SetDrawColor(255, 255, 255, alpha * 255)
        surface.SetMaterial(image)
        local crosshairSize = 64
        local x = (ScrW() - crosshairSize) / 2
        local y = (ScrH() - crosshairSize) / 4

        surface.DrawTexturedRect(x, y, crosshairSize, crosshairSize)
    end
end)