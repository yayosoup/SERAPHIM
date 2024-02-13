-- Functions used for vgui and 3d2d
yayo.UTIL.Config.Scrw, yayo.UTIL.Config.Scrh = ScrW(), ScrH()
-- Returns size value for 1080p monitor
function yayo.UTIL.GetHeight(int)
    return yayo.UTIL.Config.Scrh * (int / 1080)
end
function yayo.UTIL.GetWidth(int)
    return yayo.UTIL.Config.Scrw * (int / 1920)
end