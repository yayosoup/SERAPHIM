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
        Derma_DrawBackgroundBlur(me, me.m_fCreateTime)
        draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 200))

        local cells = LocalPlayer():GetCells()
        draw.RoundedBox(5 , 0, 0, w, h, yayo_util.Config.BackgroundGui)
        draw.SimpleText("You have " .. cells .. " Cells", YayoFont, w / 2 , h * 0.015,
        color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

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
end