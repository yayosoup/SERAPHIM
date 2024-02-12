local sound1 = nil


function rb655_playsound( snd )
    print("running")
    if ( sound1 ) then sound1:Stop() end

    sound1 = CreateSound( LocalPlayer(), snd )
    sound1:Play()

end

hook.Add("PlayerSpawn", "yesyes11yes", function(ply)
        rb655_playsound( "bioter/chatter4.ogg" )
end)