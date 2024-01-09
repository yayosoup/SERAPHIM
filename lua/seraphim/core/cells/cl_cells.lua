local cells = 0

net.Receive("UpdateDespair", function()
    cells = net.ReadInt(32)
end)

hook.Add("HUDPaint", "DrawCellsDebug", function()
    draw.SimpleText("Cells: " .. cells, "Default", ScrW() / 2, ScrH() / 1.5, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)