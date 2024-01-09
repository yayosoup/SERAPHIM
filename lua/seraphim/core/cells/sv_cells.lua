util.AddNetworkString("UpdateDespair")

local function IncrementCells()
    for _, ply in ipairs(player.GetAll()) do
        local currentCells = ply:getDarkRPVar("cells") or 0
        if currentCells < MAX_DESPAIR then
            ply:setDarkRPVar("cells", currentCells + 1)
            ply:SetPData("cells", tostring(currentCells + 1)) -- Save the new cell count
            net.Start("UpdateDespair")
                net.WriteInt(currentCells + 1, 32)
            net.Send(ply)
            print("Incremented " .. ply:Nick() .. "'s cells to " .. currentCells + 1)
        end
    end
end

hook.Add("PlayerInitialSpawn", "LoadCells", function(ply)
    local savedCells = tonumber(ply:GetPData("cells", "0")) -- Load the saved cell count
    ply:setDarkRPVar("cells", savedCells)
end)

timer.Create("CellsIncrementTimer", 10, 0, IncrementCells)