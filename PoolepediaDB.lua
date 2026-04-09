-- ============================================================
-- Poolepedia – Pool / Fish Database
-- Add or update entries here when a new expansion launches.
--
-- Key   : exact in-game fishing-pool tooltip name (English)
-- fish  : ordered list of catchable fish names
-- notes : optional extra info shown in gray on the tooltip
--
-- To add a new expansion, call addPools("Expansion Name", { ... })
-- at the bottom of this file. The expansion string must also be
-- added to the EXPANSIONS list in Poolepedia.lua.
-- ============================================================

PoolepediaDB = {}
PoolepediaDB._byName = {}   -- flat name→data index used as zone-agnostic fallback

-- Registers a block of pools under a given expansion name.
-- Each entry is tagged with its expansion and also indexed in
-- _byName so Poolepedia.lua can fall back to a name-only lookup
-- when the player is in a zone not yet in PoolepediaZones.
local function addPools(expansion, pools)
    for name, data in pairs(pools) do
        data.expansion = expansion
        PoolepediaDB[name]         = data
        PoolepediaDB._byName[name] = data
    end
end

-- -------------------------------------------------------
-- Classic
-- -------------------------------------------------------
addPools("Classic", {
    ["School of Deviate Fish"]   = { fish = { "Deviate Fish" } },
    ["Oily Blackmouth School"]   = { fish = { "Oily Blackmouth" } },
    ["Firefin Snapper School"]   = { fish = { "`Firefin Snapper" } },
    ["Stonescale Eel Swarm"]     = { fish = { "Stonescale Eel" } },
    ["Sagefish School"]          = { fish = { "Raw Sagefish" } },
    ["Greater Sagefish School"]  = { fish = { "Raw Greater Sagefish" } },
    ["Floating Wreckage"]        = { fish = { "Oily Blackmouth", "Firefin Snapper", "Stonescale Eel" },
                                     notes = "Mostly salvage with occasional fish" },
})

-- -------------------------------------------------------
-- The Burning Crusade
-- -------------------------------------------------------
addPools("The Burning Crusade", {
    ["Golden Darter School"]     = { fish = { "Golden Darter" } },
    ["Sporefish School"]         = { fish = { "Zangarian Sporefish" } },
    ["Mudfish School"]           = { fish = { "Spotted Feltail", "Figluster's Mudfish" } },
    ["Brackish Mixed School"]    = { fish = { "Spotted Feltail", "Zangarian Sporefish" } },
    ["Highland Mixed School"]    = { fish = { "Icefin Bluefish", "Golden Darter", "Figluster's Mudfish" } },
    ["Bluefish School"]          = { fish = { "Huge Bluefish" } },
    ["School of Pure Water"]     = { fish = { "Purified Draenic Water", "Golden Darter" } },
    ["Barbed Gill Trout School"] = { fish = { "Barbed Gill Trout" } },
    ["Naga Hide School"]         = { fish = { "Naga Hide" } },
})

-- -------------------------------------------------------
-- Wrath of the Lich King
-- -------------------------------------------------------
addPools("Wrath of the Lich King", {
    ["Dragonfin Angelfish School"]   = { fish = { "Dragonfin Angelfish" } },
    ["Fangtooth Herring School"]     = { fish = { "Fangtooth Herring" } },
    ["Imperial Manta Ray School"]    = { fish = { "Imperial Manta Ray" } },
    ["Moonglow Cuttlefish School"]   = { fish = { "Moonglow Cuttlefish" } },
    ["Musselback Sculpin School"]    = { fish = { "Musselback Sculpin" } },
    ["Nettlefish School"]            = { fish = { "Nettlefish" } },
    ["Glacial Salmon School"]        = { fish = { "Glacial Salmon" } },
    ["Deep Sea Monsterbelly School"] = { fish = { "Deep Sea Monsterbelly" } },
    ["Borean Man O' War School"]     = { fish = { "Borean Man O' War" } },
    ["Glassfin Minnow School"]       = { fish = { "Glassfin Minnow" } },
})

-- -------------------------------------------------------
-- Cataclysm
-- -------------------------------------------------------
addPools("Cataclysm", {
    ["Algaefin Rockfish School"] = { fish = { "Algaefin Rockfish" } },
    ["Deepsea Sagefish School"]  = { fish = { "Deepsea Sagefish" } },
    ["Fathom Eel School"]        = { fish = { "Fathom Eel" } },
    ["Highland Guppy School"]    = { fish = { "Highland Guppy" } },
    ["Lavascale Catfish School"] = { fish = { "Lavascale Catfish" } },
    ["Murglesnout School"]       = { fish = { "Murglesnout" } },
    ["Striped Lurker School"]    = { fish = { "Striped Lurker" } },
    ["Shipwreck Debris"]         = { fish = { "Fathom Eel", "Algaefin Rockfish" },
                                    notes = "Mix of fish and salvage" },
})

-- -------------------------------------------------------
-- Mists of Pandaria
-- -------------------------------------------------------
addPools("Mists of Pandaria", {
    ["Jewel Danio School"]          = { fish = { "Jewel Danio" } },
    ["Krasarang Paddlefish School"] = { fish = { "Krasarang Paddlefish" } },
    ["Giant Mantis Shrimp School"]  = { fish = { "Giant Mantis Shrimp" } },
    ["Emperor Salmon School"]       = { fish = { "Emperor Salmon" } },
    ["Tiger Gourami School"]        = { fish = { "Tiger Gourami" } },
    ["Reef Octopus School"]         = { fish = { "Reef Octopus" } },
    ["Spinefish School"]            = { fish = { "Spinefish Alpha" } },
})

-- -------------------------------------------------------
-- Warlords of Draenor
-- -------------------------------------------------------
addPools("Warlords of Draenor", {
    ["Abyssal Gulper Eel School"]  = { fish = { "Abyssal Gulper Eel" } },
    ["Blind Lake Sturgeon School"] = { fish = { "Blind Lake Sturgeon" } },
    ["Crescent Saberfish School"]  = { fish = { "Crescent Saberfish" } },
    ["Fat Sleeper School"]         = { fish = { "Fat Sleeper" } },
    ["Jawless Skulker School"]     = { fish = { "Jawless Skulker" } },
    ["Fire Ammonite School"]       = { fish = { "Fire Ammonite Tentacle" } },
})

-- -------------------------------------------------------
-- Legion
-- -------------------------------------------------------
addPools("Legion", {
    ["Cursed Queenfish School"]    = { fish = { "Cursed Queenfish" } },
    ["Highmountain Salmon School"] = { fish = { "Highmountain Salmon" } },
    ["Mossgill Perch School"]      = { fish = { "Mossgill Perch" } },
    ["Runescale Koi School"]       = { fish = { "Runescale Koi" } },
    ["Stormray School"]            = { fish = { "Stormray" } },
    ["Black Barracuda School"]     = { fish = { "Black Barracuda" } },
})

-- -------------------------------------------------------
-- Battle for Azeroth
-- -------------------------------------------------------
addPools("Battle for Azeroth", {
    ["Tiragarde Perch School"]    = { fish = { "Tiragarde Perch" } },
    ["Frenzied Fangtooth School"] = { fish = { "Frenzied Fangtooth" } },
    ["Lane Snapper School"]       = { fish = { "Lane Snapper" } },
    ["Redtail Loach School"]      = { fish = { "Redtail Loach" } },
    ["Sand Shifter School"]       = { fish = { "Sand Shifter" } },
    ["Slimy Mackerel School"]     = { fish = { "Slimy Mackerel" } },
    ["Midnight Salmon School"]    = { fish = { "Midnight Salmon" } },
})

-- -------------------------------------------------------
-- Shadowlands
-- -------------------------------------------------------
addPools("Shadowlands", {
    ["Elysian Thade School"]        = { fish = { "Elysian Thade" } },
    ["Lost Sole School"]            = { fish = { "Lost Sole" } },
    ["Silvergill Pike School"]      = { fish = { "Silvergill Pike" } },
    ["Spinefin Piranha School"]     = { fish = { "Spinefin Piranha" } },
    ["Pocked Bonefish School"]      = { fish = { "Pocked Bonefish" } },
    ["Iridescent Amberjack School"] = { fish = { "Iridescent Amberjack" } },
})

-- -------------------------------------------------------
-- Dragonflight
-- -------------------------------------------------------
addPools("Dragonflight", {
    ["Aileron Seamoth School"]      = { fish = { "Aileron Seamoth" } },
    ["Cerulean Spinefish School"]   = { fish = { "Cerulean Spinefish" } },
    ["Temporal Dragonhead School"]  = { fish = { "Temporal Dragonhead" } },
    ["Islefin Dorado School"]       = { fish = { "Islefin Dorado" } },
    ["Thousandbite Piranha School"] = { fish = { "Thousandbite Piranha" } },
    ["Scalebelly Mackerel School"]  = { fish = { "Scalebelly Mackerel" } },
    ["Prismatic Leaper School"]     = { fish = { "Prismatic Leaper" } },
})

-- -------------------------------------------------------
-- The War Within  (verify pool names in-game)
-- -------------------------------------------------------
addPools("The War Within", {
    ["Grongol Lurker School"]   = { fish = { "Grongol Lurker" } },
    ["Deepgrotto Trout School"] = { fish = { "Deepgrotto Trout" } },
    ["Gloomfish School"]        = { fish = { "Gloomfish" } },
})

-- -------------------------------------------------------
-- Midnight  (add entries here when expansion launches)
-- -------------------------------------------------------
-- addPools("Midnight", {
-- })
