util.AddNetworkString("yayo_crafting_openMenu")

hook.Add("PlayerSay", "yayo_crafting_openMenu", function( ply, text )
    if text == "!crafting" then
        print("hey")
        net.Start("yayo_crafting_openMenu")
        net.Send( ply )
    end
end)