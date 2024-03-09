print("cl_dopamine")

surface.CreateFont( "SeraphimFinalsElim", {
        font = "FinalsNotoSans",
        extended = false,
        size = 45,
        weight = 500,
} )
surface.CreateFont( "SeraphimFinalsElimSub", {
        font = "FinalsNotoSans",
        extended = false,
        size = 25,
        weight = 500,
} )

local showEliminated = false
local eliminatedPlayerName = ""
local background_black = Color(0, 0, 0, 200)
local ELIM_COLOR = Color(210, 31, 60)

net.Receive("yayo_elimsound", function()
    surface.PlaySound("death/apex_elim.wav")
    eliminatedPlayerName = net.ReadString()
    print("hello " .. surface.GetTextSize(eliminatedPlayerName))
    showEliminated = true
    timer.Simple(3, function() showEliminated = false end)
end)

hook.Add("HUDPaint", "ApexEliminatedHUD", function()
    if showEliminated then
        local scrW, scrH = ScrW(), ScrH()
        local title = "ELIMINATED"

        surface.SetFont("SeraphimFinalsElimSub")
        local titleLength, titleHeight = surface.GetTextSize(title)
        local titleTrueLength, titleTrueHeight = titleLength + 15, titleHeight - 5
        local x, y = scrW / 2, scrH / 1.15

        surface.SetFont("SeraphimFinalsElim")
        local eliminatedPlayerNameLength, eliminatedPlayerNameHeight = surface.GetTextSize(eliminatedPlayerName)
        local eliminatedPlayerNameTrueLength, eliminatedPlayerNameTrueHeight = eliminatedPlayerNameLength + 15, eliminatedPlayerNameHeight - 9
        print(eliminatedPlayerNameTrueLength, eliminatedPlayerNameTrueHeight)

        local boxX = x - eliminatedPlayerNameTrueLength / 2
        local boxY = y - eliminatedPlayerNameTrueHeight / 2 + 2

        draw.RoundedBox(0, boxX, boxY, eliminatedPlayerNameTrueLength, eliminatedPlayerNameTrueHeight, background_black)
        draw.SimpleText(eliminatedPlayerName, "SeraphimFinalsElim", x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)


        draw.RoundedBox(0, x - 48, y - 32, titleTrueLength, titleTrueHeight, background_black)
        draw.SimpleText(title, "SeraphimFinalsElimSub", x, y - 22, ELIM_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)

