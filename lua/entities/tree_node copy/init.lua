AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_pipes/pipe02_lcurve02_short.mdl")
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS)
    self:SetUseType( SIMPLE_USE )

    self:SetisAlive( true )
    self:SetisFilling( false )
    self:SetHealthPipe( 10 )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    if not IsValid(activator) or not activator:IsPlayer() then return end
    activator:ChatPrint("Buy a 'Chemical Barrel' in your F4 menu and put it on me!")
end

function ENT:StartTouch( entity )
    print(tostring(self:GetisFilling()) .. " " .. tostring(self:GetisAlive()) .. " " .. entity:GetClass())
    if self:GetisAlive() and entity:GetClass() == "chemical_barrel" and self:GetisFilling() == false then
        entity:Remove()
        self:SetisFilling( true )
        timer.Simple( yayo_util.Config.ChemicalPipeFilling, function()
            local health = self:GetHealthPipe()
            self:SetisFilling( false )
            self:SetHealthPipe( health - 1 )
            local filled_barrel = ents.Create("chemical_filled_barrel")
            filled_barrel:SetPos(self:GetPos() + Vector( 0, 0, 10))
            filled_barrel:Spawn()

            if self:GetHealthPipe() <= 0 then
                self:SetisAlive( false )
                timer.Simple(yayo_util.Config.ChemicalPipeRespawn, function()
                    self:SetisAlive( true )
                    self:SetHealthPipe( 10 )
                    print("Pipe respawned")
                end)
            end
        end)
    end
end