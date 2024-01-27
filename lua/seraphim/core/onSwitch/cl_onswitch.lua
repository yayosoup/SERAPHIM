net.Receive("blood_switch", function()
    print("Blood Switched")
    chat.AddText(color_white, "You have been made a Blood!")
    chat.AddText(color_white, "You can see other Bloods through walls.")
    chat.AddText(color_white, "You are at constant war with the Crips.")
    chat.AddText(color_white, "You may KoS Crips and Crips may KoS you.")

end)

hook.Add("PostDrawOpaqueRenderables", "DrawZombieHealthBars", function()
    for _, npc in ipairs(ents.FindByClass("npc_zombie")) do  -- Replace "npc_zombie" with the class of the zombie NPCs
        if npc:GetPos():DistToSqr(LocalPlayer():GetPos()) < 500*500 then  -- Only draw the health bar if the zombie is within 500 units
            local pos = npc:GetPos() + Vector(0, 0, npc:OBBMaxs().z + 10)  -- Position of the health bar, 10 units above the zombie
            local ang = Angle(0, LocalPlayer():EyeAngles().yaw - 90, 90)  -- Rotate the health bar to face the player

            cam.Start3D2D(pos, ang, 0.1)  -- Start the 3D2D context
                draw.RoundedBox(0, -50, -10, 100, 20, Color(0, 0, 0, 200))  -- Draw the background of the health bar
                draw.RoundedBox(0, -48, -8, 96 * (npc:Health() / npc:GetMaxHealth()), 16, Color(255, 0, 0, 200))  -- Draw the health bar
            cam.End3D2D()  -- End the 3D2D context
        end
    end
end)
