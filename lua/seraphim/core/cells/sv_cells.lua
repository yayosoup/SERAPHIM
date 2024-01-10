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

--timer.Create("CellsIncrementTimer", 10, 0, IncrementCells)

spawns = {
    Vector(-392.761627, 671.415649, -139.968750),
    Vector(-700.560486, 579.702698, -139.968750),
    Vector(-650.913818, 843.271362, -139.968750),
    Vector(738.864746, 703.131958, -100.451706),
    Vector(160.173157, 505.097168, -139.968750),
    Vector(-716.007935, 291.450073, 260.031250),

}

local function DropEntityOnDeath(ent)
    local dropEntity = ents.Create("xombocom") -- Replace "your_entity_class" with the desired entity class
    dropEntity:SetPos(ent:GetPos())
    dropEntity:Spawn()
end

timer.Create("zombieSpawner", 1, 0, function()
    local zombie = ents.Create("npc_zombie")
    local randomIndex = math.random(1, #spawns)
    local randomSpawn = spawns[randomIndex]

    zombie:SetPos(Vector(randomSpawn))
    zombie:Spawn()

    zombie:CallOnRemove("DropEntityOnDeath", DropEntityOnDeath)
end)