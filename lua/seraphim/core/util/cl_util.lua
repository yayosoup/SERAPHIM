yayo = yayo or {}
yayo.util = yayo.util or {}
print( " hi ")

-- Make fonts easily
yayo.Fonts = {}
local function CreateFont( size )
    local fontName = "yayoFont" .. size .. CurTime()
    yayo.Fonts[ size ] = true
    size = math.Round( size / 1080 * ScrH() )
    surface.CreateFont( fontName, {
        font = "FinalsNotoSans",
        size = size,
        weight = 600,
        strikeout = false,
        outline = false,
        shadow = false,
    })
    return fontName
end

function yayo.util.Font( size )
    if not yayo.Fonts[ size ] then
        yayo.Fonts[ size ] = CreateFont( size )
    end
    return yayo.Fonts[ size ]
end