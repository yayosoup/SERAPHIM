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

    local possible = {}

    for key, value in pairs(YAYO_HITMAN) do
        if value == false then
            print(key .. " " .. tostring(value))
            table.insert(possible, key)
        end
    end

    local choice = table.Random(possible)


    net.Start(tostring(choice))
    net.Send(Act)
end
