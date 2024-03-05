YAYO_MUTATION = YAYO_MUTATION or {}
YAYO_MUTATION.Config = YAYO_MUTATION.Config or {}

YAYO_MUTATION.Catalog = {
    ["hothead"] = {
        name = "Hothead",
        description = "Upon taking lethal headshot damage, explode dealing damage to nearby enemies.",
        cells = 10,
        bool = "hasHothead",
        icon = "mutations/blackmage.png"
    },
    ["bitrot"] = {
        name = "B>I>T>R>O>T",
        description = "Mark enemies with Rot on attack. Deal 5 DoT for 10 seconds. COOLDOWN: 120 seconds",
        cells = 10,
        bool = "hasBitrot",
        icon = "mutations/arcanist.png"
    },
    ["secondwind"] = {
        name = "Second Wind",
        description = "Upon taking lethal damage, gain 50 % health, but lose significant movement speed for 10 seconds.",
        cells = 10,
        bool = "hasSecondwind",
        icon = "mutations/conjurer.png"
    },
    ["ricochet"] = {
        name = "Ricochet",
        description = "When receiving damage, you have a low chance to reciprocate the damage back to the attacker.",
        cells = 10,
        bool = "hasRicochet",
        icon = "mutations/rogue.png"
    },
    ["redemption"] = {
        name = "Redemption",
        description = "Deal more damage with revolers and pistols.",
        cells = 10,
        bool = "hasRedemption",
        icon = "mutations/Machinist.png"
    },
    ["channeledOccult"] = {
        name = "Channeled: Occult",
        description = "You are channeled to the Occult. Double chance to be chosen to be Occult Potentials. Skinshape, Crusador, Martyr, etc.",
        cells = 10,
        bool = "hasChanneledOccult",
        icon = "mutations/scholar.png"
    },
    ["chganneledEsoteric"] = {
        name = "Channeled: Esoteric",
        description = "You are channeled with the Esoterics. Double chance to be chosen to be Occult Potentials. Skinshape, Crusador, Martyr, etc.",
        cells = 10,
        bool = "hasChanneledEsoteric",
        icon = "mutations/dancer.png"
    },
    ["adrenaline"] = {
        name = "Adrenaline",
        description = "Gain 25% bonus movement speed for 10 seconds while under critical health.",
        cells = 10,
        bool = "hasAdrenaline",
        icon = "mutations/ninja.png"
    },
    ["enmitysense"] = {
        name = "Enmity Sense",
        description = "Mark enemies on attack. You are able to see marked enemies through walls.",
        cells = 10,
        bool = "hasEnmitySense",
        icon = "mutations/astrologian.png"
    },

}

surface.CreateFont("YayoWorkSans20",
    {
        font = "Work Sans Regular",
        size = 20,
        weight = 500,
        antialias = true
    }
)
surface.CreateFont("YayoWorkSans20Bold",
    {
        font = "Work Sans Bold",
        size = 20,
        weight = 500,
        antialias = true
    }
)
surface.CreateFont("YayoWorkSans35",
    {
        font = "Work Sans Bold",
        size = 20,
        weight = 500,
        antialias = true
    }
)

