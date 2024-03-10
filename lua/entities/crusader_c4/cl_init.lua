include("shared.lua")

function ENT:Draw()

    local ply = LocalPlayer()
    if ply:Team() == TEAM_CRUSADER and self:GetbombPlanted() == false then
        self:SetRenderMode(RENDERMODE_TRANSALPHA)
        self:SetColor(Color(255, 255, 255, 200)) -- Half transparency for a "ghostly" look
        self:DrawModel()
    else
        self:DrawShadow( false )
    end

    if self:GetbombPlanted() == true then
        self:SetRenderMode(RENDERMODE_TRANSALPHA)
        self:SetColor(Color(255, 255, 255, 255)) -- Half transparency for a "ghostly" look
        self:DrawModel()
    end
end