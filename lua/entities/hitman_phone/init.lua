YAYO_HITMAN = {
    YAYO_TRAINYARD = GetGlobalBool("isBusyTrainyard", false),
    YAYO_SEWER = GetGlobalBool("isBusySewer", false),
    YAYO_BEACH = GetGlobalBool("isBusyBeach", false),
    YAYO_CHURCH = GetGlobalBool("isBusyChurch", false)
}

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


util.AddNetworkString("YAYO_TRAINYARD")
util.AddNetworkString("YAYO_SEWER")
util.AddNetworkString("YAYO_BEACH")
util.AddNetworkString("YAYO_CHURCH")
util.AddNetworkString("YAYO_STARTCALL")
util.AddNetworkString("YAYO_ANSWERCALL")


function ENT:Initialize()
    self:SetModel("models/props_trainstation/payphone001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetHealth(100)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(Act)
    if Act:Team() ~= TEAM_HITMAN then Act:ChatPrint("You are not a hitman!") return end
    net.Start("YAYO_STARTCALL")
    net.Send(Act)

end

local Hitman = {}

function Hitman:AddLoot(v)
    self.Inventory:AddItem(v)
end

local beachSpawns = {
    Vector(4114.0654296875, -1689.6315917969, -261.03582763672),
    Vector(3618.9506835938, -1830.2552490234, -216.80404663086),
    Vector(4043.2194824219, -850.00402832031, -276.21685791016),
    Vector(3563.0908203125, -681.82629394531, -215.1480255127),
    Vector(3443.9741210938, -1208.8701171875, -214.54234313965),
    Vector(3175.7353515625, -1795.14453125, -156.98948669434)
}
local churchSpawns = {
    Vector(1796.3360595703, 4409.4604492188, -119.53530883789),
    Vector(1307.6271972656, 4349.3725585938, -133.16563415527),
    Vector(1492.9906005859, 4358.2475585938, -149.68359375),
    Vector(1549.4738769531, 4620.8608398438, -154.33633422852),
    Vector(1794.8776855469, 4765.5659179688, -118.47206878662),
    Vector(1799.9268798828, 4941.5854492188, -141.16357421875),
    Vector(1564.8598632813, 5029.1938476563, -162.6379699707),
    Vector(1086.2084960938, 5078.8940429688, -160.63938903809),
    Vector(1045.9857177734, 4929.78125, -138.5018310546),
    Vector(859.91241455078, 5086.314453125, -138.85968017578),
    Vector(556.52917480469, 5070.8588867188, -131.09008789063),
    Vector(556.52917480469, 5070.8588867188, -131.09008789063),
    Vector(522.95501708984, 4852.5307617188, -152.4522705078),
    Vector(876.07202148438, 4755.6635742188, -139.2408447265),
    Vector(1042.9798583984, 4670.9008789063, -141.8550720214),
    Vector(949.03997802734, 4488.2216796875, -158.5761108398),
    Vector(589.96301269531, 4401.03125, -143.28373718262),

}

net.Receive("YAYO_ANSWERCALL", function(len, ply)
    local techTrash = itemstore.Item( "tech_trash" )
    techTrash:SetData("EntityData", {})
    techTrash:SetModel("models/props_lab/reciever01c.mdl")
    ply.Inventory:AddItem(techTrash)
    PrintTable(techTrash)

    local possible = {}

    for key, value in pairs(YAYO_HITMAN) do
        if value == false then
            print(key .. " " .. tostring(value))
            table.insert(possible, key)
        end
    end

    local choice = table.Random(possible)

    net.Start(tostring(choice))
    net.Send(ply)

    if choice == "YAYO_BEACH" then
        local count = 0
        YAYO_HITMAN.YAYO_BEACH = true

        for k,v in pairs (beachSpawns) do
            local enemy = ents.Create("npc_combine_s")
            enemy:SetPos(v)
            enemy:SetKeyValue("additionalequipment", "weapon_smg1")
            enemy:Spawn()
            ents.FindInSphere(enemy:GetPos(), 25)
            count = count + 1
            print("there are " .. count .. " enemies")

            enemy:AddEntityRelationship(ply, D_HT, 99)
        end
        hook.Add("OnNPCKilled", "DropTechTrashBeach", function(npc, attacker, inflictor)
            if npc:GetClass() == "npc_combine_s" then
                count = count - 1
                print("there are " .. count .. " enemies")
                local armor = ents.Create("tech_trash")
                if IsValid(armor) then
                    armor:SetPos(npc:GetPos() + Vector(0, 0, 10))
                    armor:Spawn()
                end
            end
        end)
    end
    if choice == "YAYO_CHURCH" then
        local count = 0
        YAYO_HITMAN.YAYO_CHURCH = true

        for k,v in pairs (churchSpawns) do
            local enemy = ents.Create("npc_citizen")
            enemy:SetPos(v)
            enemy:SetKeyValue("additionalequipment", "weapon_ar2")
            enemy:Spawn()
            count = count + 1
            print("there are " .. count .. " enemies")

            enemy:AddEntityRelationship(ply, D_HT, 99)
        end
        hook.Add("OnNPCKilled", "DropTechTrashBeach", function(npc, attacker, inflictor)
            if npc:GetClass() == "npc_citizen" then
                local test = itemstore.Item( "sent_ball" )
                attacker.Inventory:AddItem(test)
                count = count - 1
                print("there are " .. count .. " enemies")
                local armor = ents.Create("weapon_ak472")
                if IsValid(armor) then
                    armor:SetPos(npc:GetPos() + Vector(0, 0, 10))
                    armor:Spawn()
                end
            end
        end)

    end
end)