local despair = 0

net.Receive("UpdateDespair", function()
    despair = net.ReadInt(32)
end)

hook.Add("HUDPaint", "DrawDespair", function()
    draw.SimpleText("Despair: " .. despair, "DermaDefault", ScrW() / 45, ScrH() / 2, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end)

local pp = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1,
    ["$pp_colour_colour"] = 1,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}
local overlay_alpha = 0
local vignette_alpha = 0
local vignette_alpha_size = 0
local dsp_is_modified = false
local lerp = math.Approach

local vignette = Material("vgui/vignette.png")
local SetColor = surface.SetDrawColor
local DrawTexture = surface.DrawTexturedRect
local SetMaterial = surface.SetMaterial

local SoundLowHealth = nil
local SoundLowHealthDuck = NULL
local SoundLowHealthPlaying = false

hook.Add(
    "HUDPaintBackground",
    "Yayo_LowHealth",
    function()
        if not IsValid( ply ) then
            ply = LocalPlayer()
            return
        end
        local frametime = FrameTime()
        local health = ply:Health()
        local procHealth = ply:GetMaxHealth() * 0.25 -- What health should player be at to trigger the effect ?
        local scrw, scrh = ScrW(), ScrH()

        if not ply:Alive() then
            if SoundLowHealthPlaying then
                SoundLowHealthPlaying = false
            end
            if dsp_is_modified then
                ply:SetDSP( 0 )
                dsp_is_modified = false
            end
        end

        if health >= procHealth then
            overlay_alpha = lerp(overlay_alpha, 0, frametime * 800)
            vignette_alpha = lerp(vignette_alpha, 0, frametime * 500)
            vignette_alpha_size = lerp(vignette_alpha_size, 3, frametime * 25)
            pp["$pp_colour_contrast"] = lerp(pp["$pp_colour_contrast"], 1, frametime * 2)
            pp["$pp_colour_colour"] = lerp(pp["$pp_colour_contrast"], 1, frametime * 2)

            ply:SetDSP( 0 )

            if SoundLowHealthPlaying then
                SoundLowHealthPlaying = false
                surface.PlaySound("death/yayo_neardeath_end.wav")
                surface.PlaySound("death/finish_this.wav")
            end

            if SoundLowHealth and SoundLowHealth:IsPlaying() then
                SoundLowHealth:Stop()
            end

        else
            overlay_alpha = lerp(overlay_alpha, 255, frametime * 800)
            vignette_alpha = lerp(vignette_alpha, 255, frametime * 500)
            vignette_alpha_size = lerp(vignette_alpha_size, 0, frametime * 25)
            pp["$pp_colour_contrast"] = lerp(pp["$pp_colour_contrast"], 1.35, frametime * 2)
            pp["$pp_colour_colour"] = lerp(pp["$pp_colour_colour"], 0.8, frametime * 2)

            ply:SetDSP( 14 )
            dsp_is_modified = true

            flashbang = true
            pp["$pp_colour_contrast"] = 1.6

            if not SoundLowHealth then
                SoundLowHealth = CreateSound(LocalPlayer(), "yayo.mw2NearDeath")
                SoundLowHealth:Play()
                SoundLowHealth:SetDSP(0)
            else
                if not SoundLowHealthPlaying then
                    SoundLowHealth:Stop()
                    SoundLowHealth:Play()
                    SoundLowHealth:SetDSP(0)
                    SoundLowHealthPlaying = true
                    SoundLowHealthDuck = CurTime() + 10
                end
                if CurTime() > SoundLowHealthDuck and SoundLowHealthPlaying then
                    SoundLowHealth:FadeOut( 5 )
                end
            end
        end
        SetColor(255, 255, 255, vignette_alpha)
        SetMaterial(vignette)
        DrawTexture(-scrw * vignette_alpha_size, -scrh * vignette_alpha_size, scrw * (1 + vignette_alpha_size * 2), scrh * (1 + vignette_alpha_size * 2))
    end)

sound.Add(
    {
        name = "yayo.mw2NearDeath",
        channel = CHAN_STREAM,
        level = 0,
        sound = "death/yayo_neardeath.wav"
    }
)
sound.Add(
    {
        name = "yayo.scaryWhisper1",
        channel = CHAN_STREAM,
        level = 0,
        sound = "placenta/frighten2.wav"
    }
)
sound.Add(
    {
        name = "yayo.scaryWhisper2",
        channel = CHAN_STREAM,
        level = 0,
        sound = "placenta/frighten3.wav"
    }
)
sound.Add(
    {
        name = "yayo.scaryWhisper3",
        channel = CHAN_STREAM,
        level = 0,
        sound = "placenta/frighten4.wav"
    }
)
