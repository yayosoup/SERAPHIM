local function OpenCCMaker()
    CCMaker.ScreenPanel = vgui.Create("CCMAKERDFrame")

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
function CCMAKER.Open()
    CCMaker.ScreenPanel = vgui.Create("CCMAKERDFrame")
end

