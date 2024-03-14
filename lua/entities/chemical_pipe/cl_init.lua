include("shared.lua")

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 500 then
        return
    end

    if self:GetisAlive() then self:DrawModel() end

    if self:GetisFilling() then
        if not IsValid(self.clientsideModel) then
            self.clientsideModel = ClientsideModel("models/props/de_train/barrel.mdl", RENDERGROUP_OPAQUE)
        end

        if IsValid(self.clientsideModel) then
            self.clientsideModel:SetPos(self:GetPos() - Vector( 0, 1, 45 ))
            self.clientsideModel:SetAngles(self:GetAngles() - Angle( 0, -20, 0))
            self.clientsideModel:DrawModel()
        end
    else
        if IsValid(self.clientsideModel) then
            self.clientsideModel:Remove()
            self.clientsideModel = nil
        end
    end

    local health = self:GetHealthPipe() * 10
    local maxHealth = 100
    local barWidth = 100
    local barHeight = 20
    local healthFraction = math.Clamp(health / maxHealth, 0, 1)

    local pos = self:GetPos() + Vector(10, 0, 12)
    local ang = Angle(0, LocalPlayer():EyeAngles().yaw - 90, 90)

    if self:GetisAlive() then
        cam.Start3D2D(pos, ang, 0.1)
            surface.SetDrawColor(yayo_util.Config.BackgroundItemPanel)

            surface.DrawRect(-barWidth / 2, 0, barWidth, barHeight)

            surface.SetDrawColor(yayo_util.Config.HealthBarGreen)
            surface.DrawRect(-barWidth / 2 + 1, 1, (barWidth - 2) * healthFraction, barHeight - 2)

            local healthText = tostring(math.floor(healthFraction * 100)) .. "%"
            draw.SimpleText(healthText, "Default", 0, barHeight / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        cam.End3D2D()
    end
end

