-- ==================================================================
-- Poolepedia - Fish index
-- Pre-built reverse lookup: fishName -> sorted list of zones/pools
-- where that fish can be caught.
--
-- Generated from PoolepediaDB.lua + PoolepediaZones.lua.
-- Update this file when new expansion content is added.
--
-- Each entry: { zoneID, zoneName, poolName }
-- Entries whithin each fish are sorted alphabetically by zoneName
-- ==================================================================

PoolepediaFishIndex = {
    -- Classic --------------------------------------
    ["Deviate Fish"] = {
        { zoneID = 10, zoneName = "Northern Barrens", poolName = "School of Deviate Fish"},
        { zoneID = 17, zoneName = "Thousand Needles", poolName = "School of Deviate Fish"},
    },
    ["Oily Blackmouth"] = {
        { zoneID = 10, zoneName = "Northern Barrens", poolName = "Oily Blackmouth School"},
        { zoneID = 14, zoneName = "Swamp of Sorrows", poolName = "Oily Blackmouth School"},
        { zoneID = 77, zoneName = "Feralas", poolName = "Floating Wreckage"},
        { zoneID = 100, zoneName = "Tanaris", poolName = "Floating Wreckage"},
        { zoneID = 111, zoneName = "Wetlands", poolName = "Oily Blackmouth School"},
        { zoneID = 224, zoneName = "Stranglethorn Vale ", poolName = "Oily Blackmouth School"},
        { zoneID = 267, zoneName = "Hillsbrad Foothills", poolName = "Oily Blackmouth School"},
    },
    ["Raw Firefin Snapper"] = {
        { zoneID = 10, zoneName = "Northern Barrens", poolName = "Firefin Snapper School"},
        { zoneID = 16, zoneName = "Azshara", poolName = "Firefin Snapper School"},
        { zoneID = 224, zoneName = "Stranglethorn Vale", poolName = "Firefin Snapper School"},
        { zoneID = 267, zoneName = "Hillsbrad Foothills", poolName = "Firefin Snapper School"},
        { zoneID = 210, zoneName = "The Cape of Stranglethorn", poolName = "Firefin Snapper School"},
    },
    ["Firefin Snapper"] = {
        { zoneID = 77, zoneName = "Feralas", poolName = "Floating Wreckage"},
    },
    ["Stonescale Eel"] = {
        { zoneID = 15, zoneName = "Dustwallow Marsh", poolName = "Stonescale Eel Swarm"},
        { zoneID = 16, zoneName = "Azshara", poolName = "Stonescale Eel Swarm"},
        { zoneID = 17, zoneName = "Thousand Needles", poolName = "Stonescale Eel Swarm"},
        { zoneID = 23, zoneName = "Winterspring", poolName = "Stonescale Eel Swarm"},
        { zoneID = 77, zoneName = "Feralas", poolName = "Stonescale Eel Swarm"},
        { zoneID = 100, zoneName = "Tanaris", poolName = "Stonescale Eel Swarm"},
    },
    ["Raw Sagefish"] = {
        { zoneID = 10, zoneName = "Northern Barrens", poolName = "Sagefish School"},
        { zoneID = 14, zoneName = "Swamp of Sorrows", poolName = "Sagefish School"},
        { zoneID = 111, zoneName = "Wetlands", poolName = "Sagefish School"},
    },
    ["Raw Greater Sagefish"] = {
        { zoneID = 15, zoneName = "Dustwallow Marsh", poolName = "Greater Sagefish School"},
        { zoneID = 23, zoneName = "Winterspring", poolName = "Greater Sagefish School"},
        { zoneID = 100, zoneName = "Tanaris", poolName = "Greater Sagefish School"},
        { zoneID = 224, zoneName = "Stranglethorn Vale", poolName = "Greater Sagefish School"},
        { zoneID = 267, zoneName = "Hillsbrad Foothills", poolName = "Greater Sagefish School"},
        { zoneID = 210, zoneName = "The Cape of Stranglethorn", poolName = "Greater Sagefish School"},
    },

    -- The Burning Crusade ---------------------------
    ["Golden Darter"] = {
        { zoneID = 104, zoneName = "Blade's Edge Mountains", poolName = "Golden Darter School"},
        { zoneID = 107, zoneName = "Nagrand", poolName = "Golden Darter School"},
        { zoneID = 108, zoneName = "Terokkar Forest", poolName = "Golden Darter School"},
    },
    ["Zangarian Sporefish"] = {
        { zoneID = 119, zoneName = "Zangarmarsh", poolName = "Sporefish School"},
    },
    ["Spotted Feltail"] = {
        { zoneID = 119, zoneName = "Zangarmarsh", poolName = "Brackish Mixed School"},
        { zoneID = 119, zoneName = "Zangarmarsh", poolName = "Mudfish School"},
    },
    ["Figluster's Mudfish"] = {
        { zoneID = 104, zoneName = "Blade's Edge Mountains", poolName = "Highland Mixed School"},
        { zoneID = 119, zoneName = "Zangarmarsh", poolName = "Mudfish School"},
    },
    ["Icefin Bluefish"] = {
        { zoneID = 104, zoneName = "Blade's Edge Mountains", poolName = "Highland Mixed School"},
    },
    ["Huge Bluefish"] = {
        { zoneID = 109, zoneName = "Netherstorm", poolName = "Bluefish School"},
    },
    ["Purified Draenic Water"] = {
        { zoneID = 106, zoneName = "Shadowmoon Valley", poolName = "School of Pure Water"},
        { zoneID = 109, zoneName = "Netherstorm", poolName = "School of Pure Water"},
    },
    ["Barbed Gill Trout"] = {
        { zoneID = 104, zoneName = "Blade's Edge Mountains", poolName = "Barbed Gill Trout School"},
        { zoneID = 106, zoneName = "Shadowmoon Valley", poolName = "Barbed Gill Trout School"},
        { zoneID = 107, zoneName = "Nagrand", poolName = "Barbed Gill Trout School"},
        { zoneID = 108, zoneName = "Terokkar Forest", poolName = "Barbed Gill Trout School"},
        { zoneID = 119, zoneName = "Zangarmarsh", poolName = "Barbed Gill Trout School"},
    },
    ["Naga Hide"] = {
        { zoneID = 119, zoneName = "Zangarmarsh", poolName = "Naga Hide School"},
    },

    -- Wrath of the Lich King -----------------------
    ["Dragonfin Angelfish"] = {
        { zoneID = 120, zoneName = "Scholazar Basin", poolName = "Dragonfin Angelfish School"},
    },
    ["Fangtooth Herring"] = {
        { zoneID = 114, zoneName = "Grizzly Hills", poolName = "Fangtooth Herring School"},
        { zoneID = 116, zoneName = "Howling Fjord", poolName = "Fangtooth Herring School"},
    },
    ["Imperial Manta Ray"] = {
        { zoneID = 117, zoneName = "Borean Tundra", poolName = "Imperial Manta Ray School"},
        { zoneID = 121, zoneName = "Icecrown", poolName = "Imperial Manta Ray School"},
    },
    ["Moonglow Cuttlefish"] = {
        { zoneID = 115, zoneName = "Dragonblight", poolName = "Moonglow Cuttlefish School"},
        { zoneID = 116, zoneName = "Howling Fjord", poolName = "Moonglow Cuttlefish School"},
    },
    ["Musselback Sculpin"] = {
        { zoneID = 115, zoneName = "Dragonblight", poolName = "Musselback Sculpin School"},
        { zoneID = 117, zoneName = "Borean Tundra", poolName = "Musselback Sculpin School"},
    },
    ["Nettlefish"] = {
        { zoneID = 113, zoneName = "Zul'Drak", poolName = "Nettlefish School"},
        { zoneID = 114, zoneName = "Grizzly Hills", poolName = "Nettlefish School"},
        { zoneID = 120, zoneName = "Scholazar Basin", poolName = "Nettlefish School"},
    },
    ["Glacial Salmon"] = {
        { zoneID = 113, zoneName = "Zul'Drak", poolName = "Glacial Salmon School"},
        { zoneID = 114, zoneName = "Grizzly Hills", poolName = "Glacial Salmon School"},
        { zoneID = 118, zoneName = "Storm Peaks", poolName = "Glacial Salmon School"},
    },
    ["Deep Sea Monsterbelly"] = {
        { zoneID = 117, zoneName = "Borean Tundra", poolName = "Deep Sea Monsterbelly School"},
        { zoneID = 121, zoneName = "Icecrown", poolName = "Deep Sea Monsterbelly School"},
    },
    ["Borean Man O' War"] = {
        { zoneID = 117, zoneName = "Borean Tundra", poolName = "Borean Man O' War School"},
    },
    ["Glassfin Minnow"] = {
        { zoneID = 115, zoneName = "Dragonblight", poolName = "Glassfin Minnow School"},
        { zoneID = 116, zoneName = "Howling Fjord", poolName = "Glassfin Minnow School"},
        { zoneID = 118, zoneName = "Storm Peaks", poolName = "Glassfin Minnow School"},
        { zoneID = 125, zoneName = "Dalaran (Northrend)", poolName = "Glassfin Minnow School"},
    },

    -- Cataclysm -----------------------------------
    ["Algaefin Rockfish"] = {
        { zoneID = 198, zoneName = "Mount Hyjal", poolName = "Algaefin Rockfish School"},
        { zoneID = 207, zoneName = "Deepholm", poolName = "Algaefin Rockfish School"},
        { zoneID = 241, zoneName = "Twilight Highlands", poolName = "Algaefin Rockfish School"},
    },
    ["Deepsea Sagefish"] = {
        { zoneID = 207, zoneName = "Deepholm", poolName = "Deepsea Sagefish School"},
        { zoneID = 249, zoneName = "Uldum", poolName = "Deepsea Sagefish School"},
    },
    ["Fathom Eel"] = {
        { zoneID = 203, zoneName = "Vashj'ir - Kelp'thar Forest", poolName = "Fathom Eel School"},
        { zoneID = 204, zoneName = "Vashj'ir - Shimmering Expanse", poolName = "Fathom Eel School"},
        { zoneID = 205, zoneName = "Vashj'ir - Abyssal Depths", poolName = "Fathom Eel School"},
        { zoneID = 241, zoneName = "Twilight Highlands", poolName = "Shipwreck Debris"},
    },
    ["Highland Guppy"] = {
        { zoneID = 241, zoneName = "Twilight Highlands", poolName = "Highland Guppy School"},
        { zoneID = 249, zoneName = "Uldum", poolName = "Highland Guppy School"},
    },
    ["Lavascale Catfish"] = {
        { zoneID = 198, zoneName = "Mount Hyjal", poolName = "Lavascale Catfish School"},
        { zoneID = 249, zoneName = "Uldum", poolName = "Lavascale Catfish School"},
    },
    ["Murglesnout"] = {
        { zoneID = 203, zoneName = "Vashj'ir - Kelp'thar Forest", poolName = "Murglesnout School"},
        { zoneID = 204, zoneName = "Vashj'ir - Shimmering Expanse", poolName = "Murglesnout School"},
        { zoneID = 205, zoneName = "Vashj'ir - Abyssal Depths", poolName = "Murglesnout School"},
    },
    ["Striped Lurker"] = {
        { zoneID = 241, zoneName = "Twilight Highlands", poolName = "Striped Lurker School"},
    },

    -- Mists of Pandaria --------------------------
    ["Jewel Danio"] = {
        { zoneID = 371, zoneName = "The Jade Forest", poolName = "Jewel Danio School"},
        { zoneID = 390, zoneName = "Vale of Eternal Blossoms", poolName = "Jewel Danio School"},
    },
    ["Krasarang Paddlefish"] = {
        { zoneID = 371, zoneName = "The Jade Forest", poolName = "Krasarang Paddlefish School"},
        { zoneID = 379, zoneName = "Krasarang Wilds", poolName = "Krasarang Paddlefish School"},
    },
    ["Giant Mantis Shrimp"] = {
        { zoneID = 376, zoneName = "Valley of the Four Winds", poolName = "Giant Mantis Shrimp School"},
        { zoneID = 384, zoneName = "Dread Wastes", poolName = "Giant Mantis Shrimp School"},
        { zoneID = 388, zoneName = "Townlong Steppes", poolName = "Giant Mantis Shrimp School"},
    },
    ["Emperor Salmon"] = {
        { zoneID = 376, zoneName = "Valley of the Four Winds", poolName = "Emperor Salmon School"},
        { zoneID = 379, zoneName = "Krasarang Wilds", poolName = "Emperor Salmon School"},
        { zoneID = 381, zoneName = "Kun-Lai Summit", poolName = "Emperor Salmon School"},
    },
    ["Tiger Gourami"] = {
        { zoneID = 376, zoneName = "Valley of the Four Winds", poolName = "Tiger Gourami School"},
        { zoneID = 388, zoneName = "Townlong Steppes", poolName = "Tiger Gourami School"},
    },
    ["Reef Octopus"] = {
        { zoneID = 371, zoneName = "The Jade Forest", poolName = "Reef Octopus School"},
        { zoneID = 384, zoneName = "Dread Wastes", poolName = "Reef Octopus School"},
        { zoneID = 390, zoneName = "Vale of Eternal Blossoms", poolName = "Reef Octopus School"},
    },
    ["Spinefish Alpha"] = {
        { zoneID = 381, zoneName = "Kun-Lai Summit", poolName = "Spinefish School"},
    },

    -- Warlords of Draenor -------------------------
    ["Abyssal Gulper Eel"] = {
        { zoneID = 542, zoneName = "Spires of Arak", poolName = "Abyssal Gulper Eel School"},
        { zoneID = 572, zoneName = "Tanaan Jungle", poolName = "Abyssal Gulper Eel School"},
    },
    ["Blind Lake Sturgeon"] = {
        { zoneID = 525, zoneName = "Frostfire Ridge", poolName = "Blind Lake Sturgeon School"},
        { zoneID = 539, zoneName = "Shadowmoon Valley (Draenor)", poolName = "Blind Lake Sturgeon School"},
        { zoneID = 550, zoneName = "Nagrand (Draenor)", poolName = "Blind Lake Sturgeon School"},
        { zoneID = 535, zoneName = "Talador", poolName = "Blind Lake Sturgeon School"},
    },
    ["Crescent Saberfish"] = {
        { zoneID = 535, zoneName = "Talador", poolName = "Crescent Saberfish School"},
        { zoneID = 542, zoneName = "Spires of Arak", poolName = "Crescent Saberfish School"},
        { zoneID = 543, zoneName = "Gorgrond", poolName = "Crescent Saberfish School"},
    },
    ["Fat Sleeper"] = {
        { zoneID = 543, zoneName = "Gorgrond", poolName = "Fat Sleeper School"},
        { zoneID = 550, zoneName = "Nagrand (Draenor)", poolName = "Fat Sleeper School"},
    },
    ["Jawless Skulker"] = {
        { zoneID = 525, zoneName = "Frostfire Ridge", poolName = "Jawless Skulker School"},
        { zoneID = 535, zoneName = "Talador", poolName = "Jawless Skulker School"},
        { zoneID = 539, zoneName = "Shadowmoon Valley (Draenor)", poolName = "Jawless Skulker School"},
        { zoneID = 550, zoneName = "Nagrand (Draenor)", poolName = "Jawless Skulker School"},
    },
    ["Fire Ammonite Tentacle"] = {
        { zoneID = 542, zoneName = "Spires of Arak", poolName = "Fire Ammonite School"},
        { zoneID = 572, zoneName = "Tanaan Jungle", poolName = "Fire Ammonite School"},
    },

    -- Legion ----------------------------------------
    ["Cursed Queenfish"] = {
        { zoneID = 630, zoneName = "Azsuna", poolName = "Cursed Queenfish School"},
        { zoneID = 650, zoneName = "Stormheim", poolName = "Cursed Queenfish School"},
    },
    ["Highmountain Salmon"] = {
        { zoneID = 634, zoneName = "Highmountain", poolName = "Highmountain Salmon School"},
    },
    ["Mossgill Perch"] = {
        { zoneID = 634, zoneName = "Highmountain", poolName = "Mossgill Perch School"},
        { zoneID = 641, zoneName = "Val'sharah", poolName = "Mossgill Perch School"},
        { zoneID = 680, zoneName = "Suramar", poolName = "Mossgill Perch School"},
    },
    ["Runescale Koi"] = {
        { zoneID = 634, zoneName = "Highmountain", poolName = "Runescale Koi School"},
        { zoneID = 641, zoneName = "Val'sharah", poolName = "Runescale Koi School"},
        { zoneID = 680, zoneName = "Suramar", poolName = "Runescale Koi School"},
    },
    ["Stormray"] = {
        { zoneID = 630, zoneName = "Azsuna", poolName = "Stormray School"},
        { zoneID = 650, zoneName = "Stormheim", poolName = "Stormray School"},
    },
    ["Black Barracuda"] = {
        { zoneID = 630, zoneName = "Azsuna", poolName = "Black Barracuda School"},
        { zoneID = 650, zoneName = "Stormheim", poolName = "Black Barracuda School"},
        { zoneID = 680, zoneName = "Suramar", poolName = "Black Barracuda School"},
    },

    -- Battle for Azeroth --------------------------
    ["Tiragarde Perch"] = {
        { zoneID = 895, zoneName = "Tiragarde Sound", poolName = "Tiragarde Perch School"},
        { zoneID = 896, zoneName = "Drustvar", poolName = "Tiragarde Perch School"},
        { zoneID = 1462, zoneName = "Mechagon Island", poolName = "Tiragarde Perch School"},
    },
    ["Frenzied Fangtooth"] = {
        { zoneID = 895, zoneName = "Tiragarde Sound", poolName = "Frenzied Fangtooth School"},
        { zoneID = 896, zoneName = "Drustvar", poolName = "Frenzied Fangtooth School"},
        { zoneID = 942, zoneName = "Stormsong Valley", poolName = "Frenzied Fangtooth School"},
        { zoneID = 1355, zoneName = "Nazjatar", poolName = "Frenzied Fangtooth School"},
        { zoneID = 1462, zoneName = "Mechagon Island", poolName = "Frenzied Fangtooth School"},
    },
    ["Lane Snapper"] = {
        { zoneID = 895, zoneName = "Tiragarde Sound", poolName = "Lane Snapper School"},
        { zoneID = 942, zoneName = "Stormsong Valley", poolName = "Lane Snapper School"},
        { zoneID = 1355, zoneName = "Nazjatar", poolName = "Lane Snapper School"},
    },
    ["Redtail Loach"] = {
        { zoneID = 862, zoneName = "Zuldazar", poolName = "Redtail Loach School"},
        { zoneID = 863, zoneName = "Nazmir", poolName = "Redtail Loach School"},
    },
    ["Sand Shifter"] = {
        { zoneID = 862, zoneName = "Zuldazar", poolName = "Sand Shifter School"},
        { zoneID = 864, zoneName = "Vol'dun", poolName = "Sand Shifter School"},
    },
    ["Slimy Mackerel"] = {
        { zoneID = 895, zoneName = "Tiragarde Sound", poolName = "Slimy Mackerel School"},
        { zoneID = 942, zoneName = "Stormsong Valley", poolName = "Slimy Mackerel School"},
        { zoneID = 1355, zoneName = "Nazjatar", poolName = "Slimy Mackerel School"},
    },
    ["Midnight Salmon"] = {
        { zoneID = 862, zoneName = "Zuldazar", poolName = "Midnight Salmon School"},
        { zoneID = 863, zoneName = "Nazmir", poolName = "Midnight Salmon School"},
        { zoneID = 864, zoneName = "Vol'dun", poolName = "Midnight Salmon School"},
    },

    -- Shadowlands ---------------------------------
    ["Elysian Thade"] = {
        { zoneID = 1533, zoneName = "Bastion", poolName = "Elysian Thade School"},
        { zoneID = 1970, zoneName = "Zereth Mortis", poolName = "Elysian Thade School"},
    },
    ["Lost Sole"] = {
        { zoneID = 1565, zoneName = "Ardenweald", poolName = "Lost Sole School"},
        { zoneID = 1970, zoneName = "Zereth Mortis", poolName = "Lost Sole School"},
    },
    ["Silvergill Pike"] = {
        { zoneID = 1533, zoneName = "Bastion", poolName = "Silvergill Pike School"},
        { zoneID = 1565, zoneName = "Ardenweald", poolName = "Silvergill Pike School"},
    },
    ["Spinefin Piranha"] = {
        { zoneID = 1536, zoneName = "Maldraxxus", poolName = "Spinefin Piranha School"},
        { zoneID = 1543, zoneName = "The Maw", poolName = "Spinefin Piranha School"},
    },
    ["Pocked Bonefish"] = {
        { zoneID = 1525, zoneName = "Revendreth", poolName = "Pocked Bonefish School"},
        { zoneID = 1536, zoneName = "Maldraxxus", poolName = "Pocked Bonefish School"},
    },
    ["Iridescent Amberjack"] = {
        { zoneID = 1525, zoneName = "Revendreth", poolName = "Iridescent Amberjack School"},
        { zoneID = 1961, zoneName = "Korthia", poolName = "Iridescent Amberjack School"},
    },

    -- Dragonflight --------------------------------
    ["Aileron Seamoth"] = {
        { zoneID = 2022, zoneName = "The Waking Shores", poolName = "Aileron Seamoth School"},
        { zoneID = 2024, zoneName = "The Azure Span", poolName = "Aileron Seamoth School"},
        { zoneID = 2112, zoneName = "The Forbidden Reach", poolName = "Aileron Seamoth School"},
        { zoneID = 2133, zoneName = "Zaralek Cavern", poolName = "Aileron Seamoth School"},
    },
    ["Cerulean Spinefish"] = {
        { zoneID = 2022, zoneName = "The Waking Shores", poolName = "Cerulean Spinefish School"},
        { zoneID = 2023, zoneName = "Ohn'ahran Plains", poolName = "Cerulean Spinefish School"},
        { zoneID = 2024, zoneName = "The Azure Span", poolName = "Cerulean Spinefish School"},
        { zoneID = 2112, zoneName = "The Forbidden Reach", poolName = "Cerulean Spinefish School"},
    },
    ["Temporal Dragonhead"] = {
        { zoneID = 2022, zoneName = "The Waking Shores", poolName = "Temporal Dragonhead School"},
        { zoneID = 2025, zoneName = "Thaldraszus", poolName = "Temporal Dragonhead School"},
    },
    ["Islefin Dorado"] = {
        { zoneID = 2023, zoneName = "Ohn'ahran Plains", poolName = "Islefin Dorado School"},
        { zoneID = 2025, zoneName = "Thaldraszus", poolName = "Islefin Dorado School"},
        { zoneID = 2133, zoneName = "Zaralek Cavern", poolName = "Islefin Dorado School"},
        { zoneID = 2200, zoneName = "Emerald Dream", poolName = "Islefin Dorado School"},
    },
    ["Thousandbite Piranha"] = {
        { zoneID = 2024, zoneName = "The Azure Span", poolName = "Thousandbite Piranha School"},
    },
    ["Scalebelly Mackerel"] = {
        { zoneID = 2024, zoneName = "The Azure Span", poolName = "Scalebelly Mackerel School"},
        { zoneID = 2025, zoneName = "Thaldraszus", poolName = "Scalebelly Mackerel School"},
    },
    ["Prismatic Leaper"] = {
        { zoneID = 2023, zoneName = "Ohn'ahran Plains", poolName = "Prismatic Leaper School"},
        { zoneID = 2200, zoneName = "Emerald Dream", poolName = "Prismatic Leaper School"},
    },

    -- The War Within  ----------------------------
    ["Grongol Lurker"] = {
        { zoneID = 2248, zoneName = "Isle of Dorn", poolName = "Calm Surfacing Ripple"},
    },
    ["Deepgrotto Trout"] = {
        { zoneID = 2214, zoneName = "The Ringing Deeps", poolName = "Bloody Perch Swarm"},
    },
    ["Gloomfish"] = {
        { zoneID = 2214, zoneName = "The Ringing Deeps", poolName = "Glimmerpool"},
        { zoneID = 2248, zoneName = "Isle of Dorn", poolName = "Glimmerpool"},
    },
}