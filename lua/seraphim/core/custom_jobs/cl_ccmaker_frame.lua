local PANEL = {}
print("hello bro")

function PANEL:Init()
    local scrw, scrh = ScrW(), ScrH()
    self:SetDraggable( false )
    self:SetTitle( "" )
    self:ShowCloseButton( true )
    self:MakePopup()
    self.jobData = {}

    local frameW, frameH = scrw * 0.4, scrh * .65
    self:SetSize( frameW, frameH )
    self:Center()

    self.bodyPanel = self:Add("CCMakerBody")
    self.bodyPanel:Dock( RIGHT )
    self.bodyPanel:SetWide( frameW )
    draw.SimpleText("Class Color", "DermaDefault", self.bodyPanel:GetWide() * 0.5, self.bodyPanel:GetTall() * 0.5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)


    local className = self:CreateTextBox(self.bodyPanel, "", self.bodyPanel:GetWide() * 0.02, self.bodyPanel:GetTall() * 0.2, self.bodyPanel:GetWide() * 0.45 , self.bodyPanel:GetTall())
    className.DoChange = function()
        table.insert(self.jobData, "classname")
    end
    self:CreateColorPicker(self.bodyPanel, self.bodyPanel:GetWide() * 0.02, self.bodyPanel:GetTall() * 2.15, self.bodyPanel:GetWide() * 0.45 , self.bodyPanel:GetTall() * 3.5)
    self:CreateButton(self.bodyPanel, "Hitman Access", self.bodyPanel:GetWide() * 0.02, self.bodyPanel:GetTall() * 6, self.bodyPanel:GetWide() * 0.45 , self.bodyPanel:GetTall())
    local chooseModel = self:CreateButton(self.bodyPanel, "Choose Model", self.bodyPanel:GetWide() * 0.02, self.bodyPanel:GetTall() * 7, self.bodyPanel:GetWide() * 0.45 , self.bodyPanel:GetTall())
    chooseModel.DoClick = function()
        table.insert(self.jobData, "model")
    end
    local buyDarkRPCash = self:CreateButton(self.bodyPanel, "Buy | DarkRP Cash", self.bodyPanel:GetWide() * 0.02, self.bodyPanel:GetTall() * 8, self.bodyPanel:GetWide() * 0.225 , self.bodyPanel:GetTall())
    buyDarkRPCash.DoClick = function()
        self:CreateJob()
    end
    self:CreateButton(self.bodyPanel, "Buy | Cells", self.bodyPanel:GetWide() * 0.245, self.bodyPanel:GetTall() * 8, self.bodyPanel:GetWide() * 0.225 , self.bodyPanel:GetTall())
end
function PANEL:Paint(w, h)
end
function PANEL:CreateButton( parent, text, posX, posY, width, height )
    local btn = parent:Add("DButton")
    btn:SetSize(width, height)
    btn:SetPos(posX, posY)
    btn:SetText(text)
    return btn
end
function PANEL:CreateTextBox( parent, text, posX, posY, width, height )
    local btn = parent:Add("DTextEntry")
    btn:SetSize(width, height)
    btn:SetPos(posX, posY)
    btn:SetText(text)

    return btn
end
function PANEL:CreateColorPicker( parent, posX, posY, width, height )
    local mixer = parent:Add("DColorMixer")
    mixer:SetSize(width, height)
    mixer:SetPos(posX, posY)
    mixer:SetPalette( false )  			-- Show/hide the palette 				DEF:true
    mixer:SetAlphaBar( false ) 			-- Show/hide the alpha bar 				DEF:true
    mixer:SetWangs( false )
    return btn
end
function PANEL:CreateJob( shouldExport )
    print( "this function is running lol" )
    self.SaveData = {}
    local failed = {}

    for key,option in pairs( self.options ) do



    end

    net.Start("yayo_CCMaker_CreateJob")
        --net.WriteUInt( length, 32 )
        --net.WriteData( networkData, length )
    net.SendToServer()



end
vgui.Register("CCMAKERDFrame", PANEL, "DFrame")
