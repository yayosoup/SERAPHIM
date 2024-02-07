include("shared.lua")
AddCSLuaFile("imgui.lua")

surface.CreateFont( "SeraphimFinals", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 70,
        weight = 500,
} )
-- please help me 

net.Receive("tellPurgeModel", function()
    model = net.ReadString()

    if firstPlace then
        firstPlace.csModel = ClientsideModel(model)
        local seq = firstPlace.csModel:LookupSequence("Heal")
        if seq > 0 then
            print("hello")
            firstPlace.csModel:SetSequence(seq)
        else
            print("haii")
            firstPlace.csModel:SetSequence(5)
        end

    end
end)

net.Receive("tellPurgeVictorModel", function()
    victor = net.ReadString()
    NPC_TITLE = victor
    print(victor)
end)
local NPC_COLOR = Color(255,215,0)
local INNER_COLOR = Color( 22, 22, 22, 255 )
local v = Vector()



function ENT:Initialize()
    firstPlace = self

end


function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 500 then
        return
    end

    if firstPlace then
        self.csModel:SetPos(self:GetPos())
        self.csModel:SetAngles(self:GetAngles())
        self.csModel:DrawModel()
    end





    v.z = math.sin( CurTime() ) * 50
    if LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 then
        local z = 850
        local outlineWidth, outlineHeight = 330, 100
        local innerWidth = outlineWidth - 10
        local innerHeight = outlineHeight - 10
        local ang = self:GetAngles()

        ang:RotateAroundAxis(self:GetAngles():Right(), 90)
        ang:RotateAroundAxis(self:GetAngles():Forward(), 90)

        cam.Start3D2D(self:GetPos() + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
            draw.RoundedBox(0, v.x - outlineWidth / 2, (v.z / 2) - z, outlineWidth, outlineHeight, NPC_COLOR)
            draw.RoundedBox(0, v.x - innerWidth / 2, (v.z / 2) - z + (outlineHeight - innerHeight) / 2, innerWidth, innerHeight, INNER_COLOR)
            draw.SimpleText( NPC_TITLE, "SeraphimFinals", 2, ( v.z / 2) - z + 10, NPC_COLOR, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end

function ENT:OnRemove()
    self.csModel:Remove()
end

/*
        timer.Create("Timer", 5, 0, function()
        local chooseModel = table.Random(test)
        self.csModel:SetModel(chooseModel)
        self.csModel:SetModelScale(1, 0)
        self.csModel:SetupBones()
        local chooseSequence = table.Random(test2)
        self.csModel:SetSequence(chooseSequence)


    end)
*/

