print("sv_habits.lua loaded!")
util.AddNetworkString("startHabit")

local meta = FindMetaTable("Player")

function meta:parasocial()
    print("feeling parasocial right now...")
end

function meta:remove_parasocial()
    self.parasocial = nil
end

habits = {
    ["parasocial"] = {
        name = "Parasocial",
        desc = "The presence of others comforts you.",
        effect = meta.parasocial
    },
}

hook.Add("PlayerSpawn", "GiveHabit", function(ply)
    local chosenHabit = table.Random(habits)
    chosenHabit.effect(ply) -- Run the effect on the player
    net.Start("startHabit")
        net.WriteString(chosenHabit.name)
        net.WriteString(chosenHabit.desc)
    net.Send(ply)
end)
