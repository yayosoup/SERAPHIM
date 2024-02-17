YAYO_MUTATION = YAYO_MUTATION or {}
YAYO_MUTATION.Config = YAYO_MUTATION.Config or {}

YAYO_MUTATION.Catalog = {
    ["hothead"] = {
        name = "Hothead",
        description = "Upon taking lethal headshot damage, explode dealing damage to nearby enemies.",
        cells = 10,
        bool = "hasHothead"
    },
    ["bitrot"] = {
        name = "B>I>T>R>O>T",
        description = "Mark enemies with Rot on attack. Deal 5 DoT for 10 seconds. COOLDOWN: 120 seconds",
        cells = 10,
        bool = "hasBitrot"
    },
    ["secondwind"] = {
        name = "Second Wind",
        description = "Upon taking lethal damage, gain 50 % health, but lose significant movement speed for 10 seconds.",
        cells = 10,
        bool = "hasSecondwind"
    },
    ["ricochet"] = {
        name = "Ricochet",
        description = "When receiving damage, you have a low chance to reciprocate the damage back to the attacker.",
        cells = 10,
        bool = "hasRicochet"
    },
    ["redemption"] = {
        name = "Redemption",
        description = "Deal more damage with revolers and pistols.",
        cells = 10,
        bool = "hasRedemption"
    },

}
