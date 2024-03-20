util.AddNetworkString("yayo.craftingOpenMenu")

hook.Add("PlayerSay", "yayo.crafting_openMenu", function( ply, text )
    if text == "!crafting" then
        print("hey")
        net.Start("yayo.craftingOpenMenu")
        net.Send( ply )
    end
end)