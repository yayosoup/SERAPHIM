-- Load mutations when player loads in

function YAYO_MUTATION.IsPlayerLoaded()
    if IsValid(LocalPlayer()) then
        print("Player is loaded")
        YAYO_MUTATION.ply = LocalPlayer()
        YAYO_MUTATION.ply.YAYO_MUTATION = {}
        net.Start("YAYO_MUTATION.PlayerJoined")
        net.SendToServer()
        timer.Remove("YAYO_MUTATION_IsPlayerLoaded_Timer")
    end
end

timer.Create("YAYO_MUTATION_IsPlayerLoaded_Timer", 1, 0, YAYO_MUTATION.IsPlayerLoaded)

local YayoFont = "WorkSans20"

local function OpenMutationMenu()
    if IsValid(YayoMutationMainFrame) then
        YayoMutationMainFrame:Remove()
    end

    YAYO_MUTATION.Open()
end

net.Receive("YAYO_MUTATION.OpenMenu", function()
    OpenMutationMenu()
end)

function YAYO_MUTATION.Open()
    if IsValid(YAYO_MUTATIONS.Frame) then return end


    local scrw, scrh = ScrW(), ScrH()
    YAYO_MUTATIONS.Frame = vgui.Create("DFrame")
    YAYO_MUTATIONS.Frame:SetSize(scrw * .8, scrh * .8)
    YAYO_MUTATIONS.Frame:Center()
    YAYO_MUTATIONS.Frame:SetTitle("")
    YAYO_MUTATIONS.Frame:MakePopup()
    YAYO_MUTATIONS.Frame:ShowCloseButton(false)
    YAYO_MUTATIONS.Frame.Paint = function(me,w,h)
        local cells = LocalPlayer():GetCells()
        surface.SetDrawColor( 28, 28, 36 )
        draw.RoundedBox(10 , 0, 0, w, h, Color( 28, 28, 36))
        draw.SimpleText("You have " .. cells .. " cells.", YayoFont, w / 2 , h * 0.015,
        color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    local scroll = vgui.Create("DScrollPanel", YAYO_MUTATIONS.Frame)
    scroll:Dock(FILL)
    scroll:DockMargin(0, 5, 0, 0)

    local sbar = scroll:GetVBar()

    function sbar:Paint(w, h)
    end

    function sbar.btnUp:Paint(w, h)
    end

    function sbar.btnDown:Paint(w, h)
    end

    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(8, w * 0.5, 0, w * .4, h, Color( 36, 39, 46 ))
    end


    local frameH = YAYO_MUTATIONS.Frame:GetTall()
    local frameW = YAYO_MUTATIONS.Frame:GetWide()
    local yspace = frameH * 0.005
    for k,v in pairs( YAYO_MUTATION.Catalog ) do
        local itemPanel = vgui.Create("DPanel", scroll)
        itemPanel:DockMargin(0,0,0,yspace)
        itemPanel:Dock(TOP)
        itemPanel:SetTall(frameH * 0.1)

        local marginSpace = frameW * 0.015
        local icon = vgui.Create("DImage", itemPanel)
        icon:SetSize(itemPanel:GetWide() * 1.2, itemPanel:GetTall() * 1.) -- Set the size of the icon
        icon:SetPos(itemPanel:GetWide() * 0.2,2) -- Set the image of the icon
        icon:SetImage(v.icon) -- Set the image of the icon

        itemPanel.Paint = function(me,w,h)
            local padding = w * 0.07
            surface.SetDrawColor( 36, 39, 46 )
            surface.DrawRect(0,0,w,h)
            draw.SimpleText(v.name, YayoFont, padding , h * 0.1,
            color_red, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
            draw.SimpleText(v.description, YayoFont, padding , h * 0.4,
            color_red, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
            draw.SimpleText("Cost: " .. v.cells .. "C", YayoFont, padding , h * 0.7,
            color_red, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
        end


        if LocalPlayer():GetNWBool(v.bool) then
            local cantPurchase = vgui.Create("DButton", itemPanel)
            cantPurchase:Dock(RIGHT)
            cantPurchase:SetWide(frameW * 0.2)
            cantPurchase:DockMargin(0, marginSpace * 0.5, marginSpace, marginSpace)
            cantPurchase:SetText("")
            cantPurchase.Paint = function(me,w,h)
                surface.SetDrawColor( 74, 120, 86, 100)
                surface.DrawRect(0,0,w,h)
                draw.SimpleText("PURCHASED", "Trebuchet24", w / 2, h / 2, Color(255, 255, 255, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        else
            local purchaseButton = vgui.Create("DButton", itemPanel)
            purchaseButton:Dock(RIGHT)
            purchaseButton:SetWide(frameW * 0.2)
            purchaseButton:DockMargin(0, marginSpace * 0.5, marginSpace, marginSpace)
            purchaseButton:SetText("")
            purchaseButton.Paint = function(me,w,h)
                surface.SetDrawColor( 74, 120, 86 )
                surface.DrawRect(0,0,w,h)
                draw.SimpleText("PURCHASE", "Trebuchet24", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            purchaseButton.DoClick = function()
                print("Attempting to purchase " .. k)
                net.Start("YAYO_MUTATION.PlayerPurchaseAttempt")
                    net.WriteString(k, 32)
                net.SendToServer()
            end
        end


        local closeButton = vgui.Create("DButton", YAYO_MUTATIONS.Frame)
        closeButton:SetSize(ScrW() * 0.02, ScrH() * 0.03)
        closeButton:SetPos(YAYO_MUTATIONS.Frame:GetWide() - closeButton:GetWide(), 0)
        closeButton:SetText("X")
        closeButton:SetTextColor(Color(255,255,255))
        closeButton.Paint = function(self, w, h)
            --draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
        end
        closeButton.DoClick = function()
            YAYO_MUTATIONS.Frame:Close()
        end
    end
end

net.Receive("YAYO_MUTATION.PlayerPurchaseSuccess", function()
    chat.AddText(Color(188, 65, 59), "MUTATION ", color_grey, "|", color_white, " You have successfully purchased a mutation.")
    YAYO_MUTATIONS.Frame:Close()
end)
hook.Remove("DrawVignette")