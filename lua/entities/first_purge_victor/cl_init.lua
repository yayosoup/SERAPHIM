include("shared.lua")
AddCSLuaFile("imgui.lua")

surface.CreateFont( "SeraphimFinals", {
        font = "FinalsNotoSans", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 70,
        weight = 500,
} )

local NPC_COLOR = Color(255,215,0)
local NPC_TITLE = "First Place"
local INNER_COLOR = Color( 22, 22, 22, 255 )
local v = Vector()


function ENT:Initialize()
    test = {
        "models/Humans/Group03m/Male_04.mdl",
        "models/player/Group01/female_01.mdl",
        "models/player/alyx.mdl",
        "models/player/charple.mdl",
        "models/player/breen.mdl",
        "models/player/dod_german.mdl",
        "models/player/Group01/male_01.mdl",
    }
    test2 = {
        "idle_all_01"
    }
    local choose = table.Random(test)
    self.csModel = ClientsideModel("models/Humans/Group03m/Male_04.mdl")
    PrintTable(self.csModel:GetSequenceList())
    local seq = self.csModel:LookupSequence("Heal")
    if seq > 0 then
        print("hello")
        self.csModel:SetSequence(seq)
    else
        print("haii")
        self.csModel:SetSequence(5)
    end

end


function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 500 then
        return
    end


        self.csModel:SetPos(self:GetPos())
        self.csModel:SetAngles(self:GetAngles())
        self.csModel:DrawModel()






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