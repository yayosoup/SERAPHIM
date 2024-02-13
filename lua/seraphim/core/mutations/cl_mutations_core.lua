-- Load mutations when player loads in
PrintTable(YAYO_MUTATION)
function YAYO_MUTATION.IsPlayerLoaded()
    if IsValid(LocalPlayer()) then
        YAYO_MUTATION.ply = LocalPlayer()
        YAYO_MUTATION.ply.YAYO_MUTATION = {}
        net.Start("YAYO_MUTATION_PlayerJoined")
        net.SendToServer()
        hook.Remove("HudPaint", "YAYO_MUTATION_IsPlayerLoaded")
    end
end
hook.Add("HudPaint", "YAYO_MUTATION_IsPlayerLoaded", YAYO_MUTATION.IsPlayerLoaded)