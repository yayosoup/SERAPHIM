print("sv_habits.lua loaded!")
util.AddNetworkString("startHabit")

local meta = FindMetaTable("Player")
------------------------------------------------------------ ☆*: .｡. o(≧▽≦)o .｡.:*☆
-- Parasocial Functions🎀
function meta:remove_parasocial()
    print("Player died. Removing parasocial effect.")
    self.parasocial = nil
end
------------------------------------------------------------ (❁´◡`❁)
function meta:parasocial()
    print("feeling parasocial right now...")

    hook.Add("PlayerDeath", "RemoveParasocial", self:remove_parasocial())
end
------------------------------------------------------------ ☆*: .｡. o(≧▽≦)o .｡.:*☆
-- Antisocial Functions🎀
function meta:remove_antisocial()
    self.antisocial = nil
end
function meta:antisocial()
    print("feeling antisocial right now...")
    hook.Add("PlayerDeath", "RemoveAntisocial", self:remove_antisocial())
end
------------------------------------------------------------ (❁´◡`❁)
------------------------------------------------------------ ☆*: .｡. o(≧▽≦)o .｡.:*☆
-- Wrath Functions🎀
function meta:remove_wrath()
    self.wrath = nil
end
function meta:wrath()
    print("feeling antisocial right now...")
    hook.Add("PlayerDeath", "RemoveWrath", self:remove_wrath())
end
------------------------------------------------------------ (❁´◡`❁)

habits = {
    ["parasocial"] = {
        name = "Parasocial",
        desc = "The presence of others comforts you.",
        effect = meta.parasocial
    },
    ["antisocial"] = {
        name = "Antisocial",
        desc = "The presence of others worries you.",
        effect = meta.antisocial,
    },
    ["wrath"] = {
        name = "Wrath",
        desc = "The existence of others bothers you.",
        effect = meta.wrath
    }
}

hook.Add("PlayerSpawn", "GiveHabit", function(ply)
    local chosenHabit = table.Random(habits)
    chosenHabit.effect(ply) -- Run the effect on the player
    net.Start("startHabit")
        net.WriteString(chosenHabit.name)
        net.WriteString(chosenHabit.desc)
    net.Send(ply)
end)
