local entity = ents.Create("dark_alter")
if (IsValid(entity)) then
    entity:SetPos(Vector(-2148.002930, -1561.050171, -131.968750))
    entity:SetAngles(Angle(0, 0, 0.000000))
    entity:Spawn()

    local phys = entity:GetPhysicsObject()
    if (IsValid(phys)) then
        phys:EnableMotion(false)
    end
end