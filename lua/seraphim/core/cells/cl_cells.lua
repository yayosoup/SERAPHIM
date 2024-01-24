local cells = 0

net.Receive("updateCells", function()
    cells = net.ReadInt(32)
end)

hook.Add("HUDPaint", "DrawCells", function()
    draw.SimpleText("Cell: " .. cells, "DermaDefault", ScrW() / 45, ScrH() / 2.1, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

local x = 0

hook.Add("HUDPaint", "MyHUD", function()
    cam.Start2D()
        draw.SimpleText("Hello, world!", "Default", x, ScrH() / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    cam.End2D()

    -- Move the text 100 pixels to the right every second
    if x < ScrW() then
        x = x + 500 * FrameTime()
    end
end)