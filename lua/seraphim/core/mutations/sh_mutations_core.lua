YAYO_MUTATION = YAYO_MUTATION or {}
YAYO_MUTATION.Config = YAYO_MUTATION.Config or {}

YAYO_MUTATION.Catalog = {
    ["hothead"] = {
        name = "Hothead",
        description = "Upon taking lethal headshot damage, explode dealing damage to nearby enemies.",
        cells = 10,
        bool = "hasHothead",
        icon = "vinv/tags/derpy.png"
    },
    ["bitrot"] = {
        name = "B>I>T>R>O>T",
        description = "Mark enemies with Rot on attack. Deal 5 DoT for 10 seconds. COOLDOWN: 120 seconds",
        cells = 10,
        bool = "hasBitrot",
        icon = "theater/STATIC"
    },
    ["secondwind"] = {
        name = "Second Wind",
        description = "Upon taking lethal damage, gain 50 % health, but lose significant movement speed for 10 seconds.",
        cells = 10,
        bool = "hasSecondwind",
        icon = "vinv/tags/derpy.png"
    },
    ["ricochet"] = {
        name = "Ricochet",
        description = "When receiving damage, you have a low chance to reciprocate the damage back to the attacker.",
        cells = 10,
        bool = "hasRicochet",
        icon = "vinv/tags/derpy.png"
    },
    ["redemption"] = {
        name = "Redemption",
        description = "Deal more damage with revolers and pistols.",
        cells = 10,
        bool = "hasRedemption",
        icon = "vinv/tags/derpy.png"
    },

}
