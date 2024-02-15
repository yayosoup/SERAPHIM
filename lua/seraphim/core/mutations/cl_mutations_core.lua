-- Load mutations when player loads in
function YAYO_MUTATION.IsPlayerLoaded()
    if IsValid(LocalPlayer()) then
        print("Player is loaded")
        YAYO_MUTATION.ply = LocalPlayer()
        YAYO_MUTATION.ply.YAYO_MUTATION = {}
        net.Start("YAYO_MUTATION.PlayerJoined")
        net.SendToServer()
        timer.Remove("YAYO_MUTATION_IsPlayerLoaded_Timer")
    end
end

timer.Create("YAYO_MUTATION_IsPlayerLoaded_Timer", 1, 0, YAYO_MUTATION.IsPlayerLoaded)


local function OpenMutationMenu()
    if IsValid(YayoMutationMainFrame) then
        YayoMutationMainFrame:Remove()
    end

    YayoMutationMainFrame = vgui.Create("YayoMutationFrame")
    YayoMutationMainFrame:Center()
    YayoMutationMainFrame:MakePopup()
    YayoMutationMainFrame:Show()
end

net.Receive("YAYO_MUTATION.OpenMenu", function()
    OpenMutationMenu()
end)