local despair = 0

net.Receive("UpdateDespair", function()
    despair = net.ReadInt(32)
end)




hook.Add("HUDPaint", "DrawDespair", function()
    draw.SimpleText("Despair: " .. despair, "DermaDefault", ScrW() / 45, ScrH() / 2, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end)