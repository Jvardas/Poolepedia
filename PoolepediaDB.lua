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
PoolepediaDB._fishExp = {}  -- fish name → earliest expansion (first write wins; survives pool-name collisions)

-- Registers a block of pools under a given expansion name.
-- Each entry is tagged with its expansion and also indexed in
-- _byName so Poolepedia.lua can fall back to a name-only lookup
-- when the player is in a zone not yet in PoolepediaZones.
local function addPools(expansion, pools)
    for name, data in pairs(pools) do
        data.expansion = expansion
        PoolepediaDB[name]         = data
        PoolepediaDB._byName[name] = data
        if data.fish then
            for _, fishName in ipairs(data.fish) do
                if not PoolepediaDB._fishExp[fishName] then
                    PoolepediaDB._fishExp[fishName] = expansion
                end
            end
        end
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
    ["Mixed Ocean School"]       = { fish = { "Firefin Snapper", "Oily Blackmouth" } },
    ["Open-Water"] = { fish = { "Raw Brilliant Smallfish", "Raw Longjaw Mud Snapper", "Raw Slitherskin Mackerel",
        "Sickly Looking Fish", "Raw Bristle Whisker Catfish", "Raw Mithril Head Trout", "Raw Glossy Mightfish"}}
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
-- The War Within
-- -------------------------------------------------------
addPools("The War Within", {
    ["Glimmerpool"] = { fish = { "Bismuth Bitterling", "Crystalline Sturgeon", "Goldengill Trout", "Specular Rainbowfish", "Spiked Sea Raven", "Cursed Ghoulfish" } },
    ["Blood in the Water"] = { fish = { "Bloody Perch", "Dilly-Dally Dace", "Arathor Hammerfish", "Kaheti Slum Shark", "Sanguine Dogfish", "Cursed Ghoulfish" },
        notes = "Use Bloody Perch Bloody Perch to gain up to 10 stacks of Bloody Chum, which increases the chances of catching Sanguine Dogfish Sanguine Dogfish." },
    ["Bloody Perch Swarm"] = { fish = { "Bloody Perch", "Sanguine Dogfish", "Cursed Ghoulfish" } },
    ["Calm Surfacing Ripple"] = { fish = { "Bloody Perch", "Dilly-Dally Dace", "Dornish Pike", "Nibbling Minnow", "Quiet River Bass", "Spiked Sea Raven", "Cursed Ghoulfish" } },
    ["Festering Rotpool"] = { fish = { "Bloody Perch", "Dilly-Dally Dace", "Goldengill Trout", "Pale Huskfish", "Cursed Ghoulfish" } },
    ["Swarm of Slum Sharks"] = { fish = { "Bloody Perch", "Kaheti Slum Shark", "Cursed Ghoulfish" } },
    ["Infused Ichor Spill"] = { fish = { "Goldengill Trout", "Pale Huskfish", "Cursed Ghoulfish" } },
    ["River Bass Pool"] = { fish = { "Quiet River Bass", "Cursed Ghoulfish" } },
    ["Anglerseeker Torrent"] = { fish = { "Roaring Anglerseeker", "Spiked Sea Raven", "Cursed Ghoulfish" } },
    ["Stargazer Swarm"] = { fish = { "Whispering Stargazer", "Spiked Sea Raven", "Cursed Ghoulfish" } },
    ["Steamwheedle Runoff"] = { fish = { "\"Gold\" Fish" } },
    ["Royal Ripple"] = { fish = { "Queen's Lurefish", "Regal Dottyback" }, notes = "Use Regal Dottyback Regal Dottyback to attract this fish in open water." },
})

-- -------------------------------------------------------
-- Midnight
-- -------------------------------------------------------
addPools("Midnight", {
    ["Bloom Swarm"] = { fish = { "Eversong Trout", "Restored Songfish", "Shimmer Spinefish", "Shimmersiren" }, 
        notes = "Bloom Swarms are short-lived, usually only good for 1 cast. However, they yield only Uncommon and Rare fish." },
    ["Bubbling Bloom"] = { fish = { "Eversong Trout", "Restored Songfish", "Shimmer Spinefish", "Arcane Wyrmfish", "Lynxfish", "Sin'dorei Swarmer" } },
    ["Sunwell Swarm"] = { fish = { "Arcane Wyrmfish", "Eversong Trout", "Lynxfish", "Restored Songfish", " Sin'dorei Swarmer", "Sunwell Fish" } },
    ["Hunter Surge"] = { fish = { "Blood Hunter", "Gore Guppy" }},
    ["Obscured School"] = { fish = { "Fungalskin Pike", "Lucky Loa", "Root Crab", "Twisted Tetra" }},
    ["Surface Ripple"] = { fish = { "Blood Hunter", "Fungalskin Pike", "Gore Guppy", "Lucky Loa", "Lynxfish", "Root Crab", "Shimmer Spinefish", "Sin'dorei Swarmer" }},
    ["Blossoming Torrent"] = { fish = { "Arcane Wyrmfish", "Restored Songfish", "Shimmer Spinefish", "Sunwell Fish", "Tender Lumifin" }},
    ["Lashing Waves"] = { fish ={ "Bloomtail Minnow", "Fungalskin Pike", "Twisted Tetra" }},
    ["Oceanic Vortex"] = { fish = { "Blood Hunter", "Hollow Grouper", "Null Voidfish", "Ominous Octopus", "Shimmersiren", "Warping Wise" }, 
        notes = "Oceanic Vortexes are extremely rare fishing nodes in Voidstorm. 300 Fishing alone isn't enough; it may require high Perception to see them consistently. All fish you can fish for in Oceanic Vortexes are also available in the easier-to-find Viscous Void pools."},
    ["Careless Cargo"] = { fish = { "Treasure" }, notes = "Primary source for Fishing Lure recipes, Recipe: Amani Angler's Ward Recipe: Amani Angler's Ward, component items used to create Midnight Angler's Grand Line, as well as Motes and other treasures." },
    ["Lost Treasures"] = { fish = { "Treasure" }, notes = "Rare node; little information has been collected. Mostly seems to yield normal fish at lower levels. May require high Perception/fishing skill to get actual treasures. Usually a one-and-done node." },
    ["Viscous Void"] = { fish = { "Blood Hunter", "Hollow Grouper", "Null Voidfish", "Ominous Octopus", "Shimmersiren", "Warping Wise" }, 
        notes = "Consistent (and much safer) place to fish for species native to Voidstorm. Any fish you can get from an Oceanic Vortex, you can also get from a Viscous Void pool. The only drawback is high competition." },
    ["Open-Water"] = { fish = { "Blood Hunter", "Eversong Trout", "Fungalskin Pike", "Gore Guppy", "Lynxfish", "Restored Songfish", "Shimmer Spinefish", "Sin'dorei Swarmer", "Shimmersiren", 
        "Arcane Wyrmfish", "Sunwell Fish", "Lucky Loa", "Root Crab", "Twisted Tetra", "Tender Lumifin", "Bloomtail Minnow", "Hollow Grouper", "Null Voidfish", "Ominous Octopus", "Warping Wise",  } }
})
