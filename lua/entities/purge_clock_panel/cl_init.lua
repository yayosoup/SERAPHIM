local PURGE_COLOR = Color(210, 31, 60)
local BLACK = Color(0, 0, 0)
local WHITE = Color(255, 255, 255)
local FLASH_FREQUENCY = 5
local POSITION = Vector(24,-4,1.6)
local ANGLE_1 = Angle(0,90,0)
local ANGLE_2 = Angle(0,0,0)
local SCALE_1 = 0.1
local SCALE_2 = 1
local WIDTH = 2000
local HEIGHT = 750

function ENT:Draw()
    self:DrawModel()

    if imgui.Entity3D2D(self, POSITION, ANGLE_1, SCALE_1, WIDTH, HEIGHT) then
        surface.SetDrawColor(PURGE_COLOR)
        surface.DrawRect(-1380, -1420, 2845, 2370)

        surface.SetDrawColor(BLACK)
        surface.DrawRect(-1000, -1370, 1000, 2270)

        imgui.End3D2D()
    end

    if imgui.Entity3D2D(self, POSITION, ANGLE_2, SCALE_2, WIDTH, HEIGHT) then
        if math.sin(CurTime() * FLASH_FREQUENCY) > 0 then
            draw.SimpleText("PURGE", "AWESOME", -25, -75, WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        imgui.End3D2D()
    end
end