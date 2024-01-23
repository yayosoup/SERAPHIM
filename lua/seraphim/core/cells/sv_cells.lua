local _P = FindMetaTable("Player")

util.AddNetworkString("updateCells")

function _P:CellsSave()
    self:SetPData("cells", self:GetNWInt("cells"))
end

function _P:CellsLoad()
    if  self:GetPData("cells") == nil  then
        self:SetPData("cells", 1)
        self:SetNWInt("cells", 1)
    else
        self:SetNWInt("cells", self:GetPData("cells"))
    end
    net.Start("updateCells")
        net.WriteInt(self:GetNWInt("cells"), 32)
    net.Send(self)
end

function _P:AddCells(n)
    self:SetNWInt("cells", self:GetNWInt("cells") + n)
    self:CellsSave()
end

hook.Add("PlayerInitialSpawn", "CellsLoad", function(ply)
    ply:CellsLoad()
end)

hook.Add("PlayerDisconnected", "CellsSave", function(ply)
    ply:CellsSave()
end)
--[[
timer.Create("CellsCheck", 5, 0, function()

    for k , v in pairs(player.GetAll()) do
        print("Adding cells to " .. v:Nick())
        v:AddCells(1)
        net.Start("updateCells")
            net.WriteInt(v:GetNWInt("cells"), 32)
        net.Send(v)
    end
end)
--]]