local cells = 0

net.Receive("updateCells", function()
    cells = net.ReadInt(32)
end)

hook.Add("HUDPaint", "DrawCells", function()
    draw.SimpleText("Cell: " .. cells, "DermaDefault", ScrW() / 45, ScrH() / 2.1, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end)