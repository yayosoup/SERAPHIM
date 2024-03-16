yayo = yayo or {}

-- Define a table of sound paths for DConfig2.
yayo.Sounds = {
    popup = "dconfig/tadah_08.wav",
    fail = "dconfig/error_07.wav",
    open = "dconfig/woosh_02.wav",
    close = "dconfig/woosh_09.wav",
    focus = "dconfig/click_08.wav",
    click = "dconfig/click_07.wav",
    checkbox = "dconfig/click_13.wav",
}

-- Functions used for vgui and 3d2d
yayo.UTIL.Config.Scrw, yayo.UTIL.Config.Scrh = ScrW(), ScrH()
-- Returns size value for 1080p monitor
function yayo.UTIL.GetHeight( int )
    return yayo.UTIL.Config.Scrh * (int / 1080)
end
function yayo.UTIL.GetWidth( int )
    return yayo.UTIL.Config.Scrw * (int / 1920)
end

function yayo.UTIL.PlaySound( sound )
    -- Check if sound is enabled and the sound path exists.
    if not DCONFIG2.IngameConfig.sounds or not DCONFIG2.Sounds[sound] then return end
    -- Play the specified sound.
    surface.PlaySound( DCONFIG2.Sounds[sound] )
end

