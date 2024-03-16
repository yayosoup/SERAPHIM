local function OpenCCMaker()
    CCMaker.Open()

end
net.Receive(
    "yayo_CCMaker_Open",
    function()
    if IsValid(CCMakerFrame) then
        CCMakerFrame:Remove()
    end

    OpenCCMaker()
    end
)
function CCMaker.Open()
    -- awesome mode
    if IsValid(CCMaker.Frame) then return end

    local playerMutation = LocalPlayer():GetNWInt("mutationCount", 0)
    local scrw, scrh = ScrW(), ScrH()
    CCMaker.Frame = vgui.Create("DFrame")
    CCMaker.Frame:SetSize(scrw * .35, scrh * .5)
    CCMaker.Frame:Center()
    CCMaker.Frame:SetTitle("")
    CCMaker.Frame:MakePopup(true)
    CCMaker.Frame:ShowCloseButton(false)

    CCMaker.Frame.Paint = function(me,w,h)
        draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 200))

        draw.RoundedBox(5 , 0, 0, w, h, yayo_util.Config.BackgroundGui)
    end




    local frameH = CCMaker.Frame:GetTall()
    local frameW = CCMaker.Frame:GetWide()
    local marginSpace = frameW * 0.015

    local closeButton = vgui.Create("DButton", CCMaker.Frame)
    closeButton:SetSize(ScrW() * 0.02, ScrH() * 0.03)
    closeButton:SetPos(CCMaker.Frame:GetWide() - closeButton:GetWide(), 0)
    closeButton:SetText("")
    closeButton:SetTextColor(Color(255,255,255))
    closeButton.Paint = function(self, w, h)
        surface.SetDrawColor(255, 255, 255)
        draw.SimpleText("X", "Trebuchet24", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    closeButton.DoClick = function()
        CCMaker.Frame:Close()
    end

    local className = vgui.Create( "DTextEntry", CCMaker.Frame )
    className:SetSize( frameW * 0.5, frameH * 0.05 )
    className:SetPlaceholderText( "Class Name" )

    local mixer = vgui.Create( "DColorMixer", CCMaker.Frame )
    mixer:SetPalette( false )
    mixer:SetAlphaBar( false )
    mixer:SetWangs( false )
    mixer:SetSize( frameW * 0.5, frameH * 0.2 )
    mixer:SetPos( frameW * 0, frameH * 0.05 )

    local buyPolice = vgui.Create("DButton", CCMaker.Frame)
    buyPolice:SetSize(frameW * 0.5, frameH * 0.05)
    buyPolice:SetPos(frameW * 0, frameH * 0.25)
    buyPolice:SetText("Police Class/Tools")

    local buyModel = vgui.Create("DButton", CCMaker.Frame)
    buyModel:SetSize(frameW * 0.5, frameH * 0.05)
    buyModel:SetPos(frameW * 0, frameH * 0.30)
    buyModel:SetText("Choose model")

    local buyWithCash = vgui.Create("DButton", CCMaker.Frame)
    buyWithCash:SetSize(frameW * 0.25, frameH * 0.05)
    buyWithCash:SetPos(frameW * 0, frameH * 0.35)
    buyWithCash:SetText("Buy with DarkRP Cash")

    local buyWithCells = vgui.Create("DButton", CCMaker.Frame)
    buyWithCells:SetSize(frameW * 0.25, frameH * 0.05)
    buyWithCells:SetPos(frameW * .25, frameH * 0.35)
    buyWithCells:SetText("Buy with Cells")
end