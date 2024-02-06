local CURRENT_COUNT = GetGlobalInt("current_count", 1)
local stock = {}

timer.Create("should_manufacture", 999, 0, function()
    print("should manufacture?")
    if CURRENT_COUNT == 0 then return end

    for i = 1, CURRENT_COUNT do
        local randomIndex = math.random(1, #CustomShipments)
        local randomWeapon = CustomShipments[randomIndex]
        print("adding to stock!")
        table.insert(stock, randomWeapon)
        PrintTable(stock)
    end
end)

hook.Add("PlayerSpawn", "testinglol", function(ply)
    local foundKey
    for k, v in pairs(CustomShipments) do
        foundKey = math.random(table.Count(CustomShipments))
    end

    local shipment = ents.Create("spawned_shipment")
    shipment.SID = ply.SID
    shipment:Setowning_ent(ply)
    shipment:SetContents(foundKey, 10)
    shipment:SetPos(Vector(330.917480, -913.302856, -139.968750))
    shipment.nodupe = true
    shipment:Spawn()
    shipment:SetPlayer(ply)
    shipment:SetModel("models/Items/item_item_crate.mdl")
    shipment:PhysicsInit(SOLID_VPHYSICS)
    shipment:SetMoveType(MOVETYPE_VPHYSICS)
    shipment:SetSolid(SOLID_VPHYSICS)
    local phys = shipment:GetPhysicsObject()
    phys:Wake()
    if CustomShipments[foundKey].onBought then
        CustomShipments[foundKey].onBought(ply, CustomShipments[foundKey], weapon)
    end

    hook.Call("playerBoughtShipment", nil, ply, CustomShipments[foundKey], weapon)
end)

timer.Create("YesYesYes", 999, 0, function()
    local players = player.GetAll()
    local ply

    if #players > 0 then
        ply = players[math.random(#players)]
    end

    local foundKey
    for k, v in pairs(CustomShipments) do
        foundKey = math.random(table.Count(CustomShipments))
    end

    local shipment = ents.Create("spawned_shipment")
    shipment:Setowning_ent(ply)
    shipment:SetContents(5, 10)
    shipment:SetPos(Vector(330.917480, -913.302856, -139.968750) + Vector(70, 0, math.random(20, 150)))
    shipment.nodupe = true
    shipment:Spawn()
    shipment:SetPlayer(ply)
    shipment:SetModel("models/Items/item_item_crate.mdl")
    shipment:PhysicsInit(SOLID_VPHYSICS)
    shipment:SetMoveType(MOVETYPE_VPHYSICS)
    shipment:SetSolid(SOLID_VPHYSICS)
    local phys = shipment:GetPhysicsObject()
    phys:Wake()
    if CustomShipments[foundKey].onBought then
        CustomShipments[foundKey].onBought(ply, CustomShipments[foundKey], weapon)
    end

    hook.Call("playerBoughtShipment", nil, ply, CustomShipments[foundKey], weapon)
end)

local shipmentIDs = table.GetKeys(CustomShipments)

for _, id in ipairs(shipmentIDs) do
    print("Shipment ID: " .. id)
end