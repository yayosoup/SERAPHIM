local _P = FindMetaTable("Player")

util.AddNetworkString("updateCells")


function _P:CellsSave()
    self:SetPData("cells", self:GetNWInt("cells"))
end

function _P:CellsLoad()
    local testCells = self:GetPData("cells")
    if testCells == nil then
        print("No cells found for " .. self:Nick() .. ". Setting to 1.")
        self:SetPData("cells", 1)
        self:SetNWInt("cells", 1)
    else
        print("Loading cells for " .. self:Nick() .. ": " .. testCells)
        self:SetNWInt("cells", testCells)
    end
    net.Start("updateCells")
        net.WriteInt(self:GetNWInt("cells"), 32)
    net.Send(self)
end

function _P:AddCells(n)
    self:SetNWInt("cells", self:GetPData("cells") + n)
    self:CellsSave()
    net.Start("updateCells")
        net.WriteInt(self:GetNWInt("cells"), 32)
    net.Send(self)
end
function _P:RemoveCells(n)
    self:SetNWInt("cells", self:GetPData("cells") - n)
    self:CellsSave()
end

hook.Add("PlayerInitialSpawn", "CellsLoad", function(ply)
    ply:CellsLoad()
end)

hook.Add("PlayerDisconnected", "CellsSave", function(ply)
    ply:CellsSave()
end)

timer.Create("CellsCheck", 2, 0, function()
    for k , v in pairs(player.GetAll()) do
        v:AddCells(1)
        net.Start("updateCells")
            net.WriteInt(v:GetNWInt("cells"), 32)
        net.Send(v)
    end
end)
