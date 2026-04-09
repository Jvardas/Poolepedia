-- ============================================================
-- Poolepedia – Zone → Pool Database
--
-- Maps uiMapID → set of pool names that can appear in that zone.
-- Used by Poolepedia.lua to filter the tooltip by the player's
-- current zone (C_Map.GetBestMapForUnit("player")).
--
-- Sources:
--   Zone IDs  : verified against GatherMate2_Data/FishData.lua
--               (github.com/Nevcairiel/GatherMate2_Data)
--   Pool names: cross-referenced with GatherMate2/Constants.lua
--               (github.com/Nevcairiel/GatherMate2)
--
-- To add a new zone: add an addZonePools() call at the bottom.
-- To add Midnight zones: find uiMapIDs with
--   /script print(C_Map.GetBestMapForUnit("player"))
-- while standing in each zone, then add a block below.
--
-- If GatherMate2 + GatherMate2_Data are both installed, Poolepedia
-- will ALSO build this table dynamically at runtime (ADDON_LOADED),
-- which automatically covers any zones we have not yet hand-coded.
-- The static table below is the fallback for players who don't have
-- GatherMate2 installed.
-- ============================================================

PoolepediaZones = {}
PoolepediaZones._byName = {}   -- flat name→true index (zone-agnostic fallback)

local function addZonePools(uiMapID, pools)
    if not PoolepediaZones[uiMapID] then
        PoolepediaZones[uiMapID] = {}
    end
    for _, poolName in ipairs(pools) do
        PoolepediaZones[uiMapID][poolName] = true
        PoolepediaZones._byName[poolName]  = true
    end
end

-- ============================================================
-- Classic
-- ============================================================

-- The Barrens (uiMapID 10)
addZonePools(10, {
    "Sagefish School",
    "School of Deviate Fish",
    "Oily Blackmouth School",
    "Firefin Snapper School",
    "Floating Wreckage",
})

-- Hillsbrad Foothills (uiMapID 267)
addZonePools(267, {
    "Oily Blackmouth School",
    "Firefin Snapper School",
    "Sagefish School",
    "Greater Sagefish School",
    "Floating Wreckage",
})

-- Stranglethorn Vale (uiMapID 224)
addZonePools(224, {
    "Oily Blackmouth School",
    "Firefin Snapper School",
    "Greater Sagefish School",
    "Floating Wreckage",
})

-- The Cape of Stranglethorn (uiMapID 210)
addZonePools(210, {
    "Oily Blackmouth School",
    "Firefin Snapper School",
    "Greater Sagefish School",
    "Floating Wreckage",
})

-- Feralas (uiMapID 77)
addZonePools(77, {
    "Oily Blackmouth School",
    "Stonescale Eel Swarm",
    "Floating Wreckage",
})

-- Tanaris (uiMapID 100)
addZonePools(100, {
    "Stonescale Eel Swarm",
    "Greater Sagefish School",
    "Floating Wreckage",
})

-- Azshara (uiMapID 16)
addZonePools(16, {
    "Stonescale Eel Swarm",
    "Firefin Snapper School",
    "Floating Wreckage",
})

-- Swamp of Sorrows (uiMapID 14)
addZonePools(14, {
    "Oily Blackmouth School",
    "Sagefish School",
    "Floating Wreckage",
})

-- Wetlands (uiMapID 111)
addZonePools(111, {
    "Oily Blackmouth School",
    "Sagefish School",
    "Floating Wreckage",
})

-- Arathi Highlands (uiMapID 14)
addZonePools(14, {
    "Oily Blackmouth School",
    "Sagefish School",
    "Floating Wreckage",
})

-- Dustwallow Marsh (uiMapID 15)
addZonePools(15, {
    "Stonescale Eel Swarm",
    "Sagefish School",
    "Greater Sagefish School",
    "Floating Wreckage",
})

-- Thousand Needles / Shimmering Flats (uiMapID 17)
addZonePools(17, {
    "School of Deviate Fish",
    "Stonescale Eel Swarm",
})

-- Winterspring (uiMapID 23)
addZonePools(23, {
    "Stonescale Eel Swarm",
    "Greater Sagefish School",
})

-- ============================================================
-- The Burning Crusade
-- ============================================================

-- Zangarmarsh (uiMapID 119)
addZonePools(119, {
    "Sporefish School",
    "Brackish Mixed School",
    "Mudfish School",
    "Barbed Gill Trout School",
    "Naga Hide School",
})

-- Nagrand (uiMapID 107)
addZonePools(107, {
    "Mudfish School",
    "Golden Darter School",
    "Barbed Gill Trout School",
})

-- Terokkar Forest (uiMapID 108)
addZonePools(108, {
    "Golden Darter School",
    "Barbed Gill Trout School",
})

-- Shadowmoon Valley (uiMapID 106)
addZonePools(106, {
    "Barbed Gill Trout School",
    "School of Pure Water",
})

-- Skettis / Terrokar (uiMapID 108)
addZonePools(108, {
    "Highland Mixed School",
})

-- Netherstorm (uiMapID 109)
addZonePools(109, {
    "School of Pure Water",
    "Bluefish School",
})

-- Blade's Edge Mountains (uiMapID 104)
addZonePools(104, {
    "Golden Darter School",
    "Barbed Gill Trout School",
    "Highland Mixed School",
})

-- ============================================================
-- Wrath of the Lich King
-- ============================================================

-- Borean Tundra (uiMapID 117)
addZonePools(117, {
    "Borean Man O' War School",
    "Deep Sea Monsterbelly School",
    "Imperial Manta Ray School",
    "Musselback Sculpin School",
})

-- Howling Fjord (uiMapID 116)
addZonePools(116, {
    "Fangtooth Herring School",
    "Glassfin Minnow School",
    "Moonglow Cuttlefish School",
})

-- Dragonblight (uiMapID 115)
addZonePools(115, {
    "Moonglow Cuttlefish School",
    "Glassfin Minnow School",
    "Musselback Sculpin School",
})

-- Grizzly Hills (uiMapID 114)
addZonePools(114, {
    "Fangtooth Herring School",
    "Glacial Salmon School",
    "Nettlefish School",
})

-- Zul'Drak (uiMapID 113)
addZonePools(113, {
    "Nettlefish School",
    "Glacial Salmon School",
})

-- Scholazar Basin (uiMapID 120)
addZonePools(120, {
    "Nettlefish School",
    "Dragonfin Angelfish School",
})

-- Storm Peaks (uiMapID 118)
addZonePools(118, {
    "Glacial Salmon School",
    "Glassfin Minnow School",
})

-- Icecrown (uiMapID 121)
addZonePools(121, {
    "Deep Sea Monsterbelly School",
    "Imperial Manta Ray School",
})

-- Dalaran (Northrend) (uiMapID 125)
addZonePools(125, {
    "Glassfin Minnow School",
})

-- ============================================================
-- Cataclysm
-- ============================================================

-- Mount Hyjal (uiMapID 198)
addZonePools(198, {
    "Algaefin Rockfish School",
    "Lavascale Catfish School",
})

-- Vashj'ir – Kelp'thar Forest (uiMapID 203)
addZonePools(203, {
    "Fathom Eel School",
    "Murglesnout School",
    "Shipwreck Debris",
})

-- Vashj'ir – Shimmering Expanse (uiMapID 204)
addZonePools(204, {
    "Fathom Eel School",
    "Murglesnout School",
    "Shipwreck Debris",
})

-- Vashj'ir – Abyssal Depths (uiMapID 205)
addZonePools(205, {
    "Fathom Eel School",
    "Murglesnout School",
    "Shipwreck Debris",
})

-- Deepholm (uiMapID 207)
addZonePools(207, {
    "Algaefin Rockfish School",
    "Deepsea Sagefish School",
})

-- Uldum (uiMapID 249)
addZonePools(249, {
    "Deepsea Sagefish School",
    "Lavascale Catfish School",
    "Highland Guppy School",
})

-- Twilight Highlands (uiMapID 241)
addZonePools(241, {
    "Algaefin Rockfish School",
    "Striped Lurker School",
    "Highland Guppy School",
    "Shipwreck Debris",
})

-- ============================================================
-- Mists of Pandaria
-- ============================================================

-- The Jade Forest (uiMapID 371)
addZonePools(371, {
    "Jewel Danio School",
    "Reef Octopus School",
    "Krasarang Paddlefish School",
})

-- Valley of the Four Winds (uiMapID 376)
addZonePools(376, {
    "Jewel Danio School",
    "Giant Mantis Shrimp School",
    "Emperor Salmon School",
    "Tiger Gourami School",
})

-- Krasarang Wilds (uiMapID 379)
addZonePools(379, {
    "Krasarang Paddlefish School",
    "Reef Octopus School",
    "Emperor Salmon School",
})

-- Kun-Lai Summit (uiMapID 381)
addZonePools(381, {
    "Emperor Salmon School",
    "Spinefish School",
})

-- Townlong Steppes (uiMapID 388)
addZonePools(388, {
    "Giant Mantis Shrimp School",
    "Tiger Gourami School",
})

-- Dread Wastes (uiMapID 384)
addZonePools(384, {
    "Giant Mantis Shrimp School",
    "Reef Octopus School",
})

-- Vale of Eternal Blossoms (uiMapID 390)
addZonePools(390, {
    "Jewel Danio School",
    "Reef Octopus School",
})

-- ============================================================
-- Warlords of Draenor
-- ============================================================

-- Shadowmoon Valley (Draenor) (uiMapID 539)
addZonePools(539, {
    "Jawless Skulker School",
    "Blind Lake Sturgeon School",
})

-- Frostfire Ridge (uiMapID 525)
addZonePools(525, {
    "Jawless Skulker School",
    "Blind Lake Sturgeon School",
})

-- Gorgrond (uiMapID 543)
addZonePools(543, {
    "Crescent Saberfish School",
    "Fat Sleeper School",
})

-- Talador (uiMapID 535)
addZonePools(535, {
    "Crescent Saberfish School",
    "Jawless Skulker School",
    "Blind Lake Sturgeon School",
})

-- Spires of Arak (uiMapID 542)
addZonePools(542, {
    "Abyssal Gulper Eel School",
    "Fire Ammonite School",
    "Crescent Saberfish School",
})

-- Nagrand (Draenor) (uiMapID 550)
addZonePools(550, {
    "Fat Sleeper School",
    "Jawless Skulker School",
    "Blind Lake Sturgeon School",
})

-- Tanaan Jungle (uiMapID 572)
addZonePools(572, {
    "Abyssal Gulper Eel School",
    "Fire Ammonite School",
})

-- ============================================================
-- Legion
-- ============================================================

-- Azsuna (uiMapID 630)
addZonePools(630, {
    "Black Barracuda School",
    "Cursed Queenfish School",
    "Stormray School",
})

-- Val'sharah (uiMapID 641)
addZonePools(641, {
    "Runescale Koi School",
    "Mossgill Perch School",
})

-- Highmountain (uiMapID 634)
addZonePools(634, {
    "Highmountain Salmon School",
    "Mossgill Perch School",
    "Runescale Koi School",
})

-- Stormheim (uiMapID 650)
addZonePools(650, {
    "Cursed Queenfish School",
    "Stormray School",
    "Black Barracuda School",
})

-- Suramar (uiMapID 680)
addZonePools(680, {
    "Runescale Koi School",
    "Mossgill Perch School",
    "Black Barracuda School",
})

-- ============================================================
-- Battle for Azeroth
-- ============================================================

-- Tiragarde Sound (uiMapID 895)
addZonePools(895, {
    "Tiragarde Perch School",
    "Lane Snapper School",
    "Frenzied Fangtooth School",
    "Slimy Mackerel School",
})

-- Drustvar (uiMapID 896)
addZonePools(896, {
    "Tiragarde Perch School",
    "Lane Snapper School",
    "Frenzied Fangtooth School",
})

-- Stormsong Valley (uiMapID 942)
addZonePools(942, {
    "Frenzied Fangtooth School",
    "Slimy Mackerel School",
    "Lane Snapper School",
})

-- Zuldazar (uiMapID 862)
addZonePools(862, {
    "Redtail Loach School",
    "Sand Shifter School",
    "Midnight Salmon School",
})

-- Nazmir (uiMapID 863)
addZonePools(863, {
    "Redtail Loach School",
    "Midnight Salmon School",
})

-- Vol'dun (uiMapID 864)
addZonePools(864, {
    "Sand Shifter School",
    "Midnight Salmon School",
})

-- Mechagon Island (uiMapID 1462)
addZonePools(1462, {
    "Tiragarde Perch School",
    "Frenzied Fangtooth School",
})

-- Nazjatar (uiMapID 1355)
addZonePools(1355, {
    "Frenzied Fangtooth School",
    "Slimy Mackerel School",
    "Lane Snapper School",
})

-- ============================================================
-- Shadowlands
-- ============================================================

-- Bastion (uiMapID 1533)
addZonePools(1533, {
    "Elysian Thade School",
    "Silvergill Pike School",
})

-- Maldraxxus (uiMapID 1536)
addZonePools(1536, {
    "Spinefin Piranha School",
    "Pocked Bonefish School",
})

-- Ardenweald (uiMapID 1565)
addZonePools(1565, {
    "Lost Sole School",
    "Silvergill Pike School",
})

-- Revendreth (uiMapID 1525)
addZonePools(1525, {
    "Iridescent Amberjack School",
    "Pocked Bonefish School",
})

-- The Maw (uiMapID 1543)
addZonePools(1543, {
    "Spinefin Piranha School",
})

-- Korthia (uiMapID 1961)
addZonePools(1961, {
    "Iridescent Amberjack School",
})

-- Zereth Mortis (uiMapID 1970)
addZonePools(1970, {
    "Elysian Thade School",
    "Lost Sole School",
})

-- ============================================================
-- Dragonflight
-- ============================================================

-- The Waking Shores (uiMapID 2022)
addZonePools(2022, {
    "Aileron Seamoth School",
    "Cerulean Spinefish School",
    "Temporal Dragonhead School",
})

-- Ohn'ahran Plains (uiMapID 2023)
addZonePools(2023, {
    "Prismatic Leaper School",
    "Cerulean Spinefish School",
    "Islefin Dorado School",
})

-- The Azure Span (uiMapID 2024)
addZonePools(2024, {
    "Cerulean Spinefish School",
    "Aileron Seamoth School",
    "Thousandbite Piranha School",
    "Scalebelly Mackerel School",
})

-- Thaldraszus (uiMapID 2025)
addZonePools(2025, {
    "Islefin Dorado School",
    "Temporal Dragonhead School",
    "Scalebelly Mackerel School",
})

-- Zaralek Cavern (uiMapID 2133)
addZonePools(2133, {
    "Aileron Seamoth School",
    "Islefin Dorado School",
})

-- The Forbidden Reach (uiMapID 2112)
addZonePools(2112, {
    "Aileron Seamoth School",
    "Cerulean Spinefish School",
})

-- Emerald Dream (uiMapID 2200)
addZonePools(2200, {
    "Prismatic Leaper School",
    "Islefin Dorado School",
})

-- ============================================================
-- The War Within  (pool names unverified – check in-game)
-- ============================================================

-- Isle of Dorn (uiMapID 2248)
addZonePools(2248, {
    "Calm Surfacing Ripple",
    "River Bass Pool",
    "Glimmerpool",
})

-- The Ringing Deeps (uiMapID 2214)
addZonePools(2214, {
    "Bloody Perch Swarm",
    "Festering Rotpool",
    "Glimmerpool",
})

-- Hallowfall (uiMapID 2215)
addZonePools(2215, {
    "Stargazer Swarm",
    "Anglerseeker Torrent",
    "Royal Ripple",
})

-- Azj-Kahet (uiMapID 2255)
addZonePools(2255, {
    "Swarm of Slum Sharks",
    "Blood in the Water",
    "Infused Ichor Spill",
})

-- ============================================================
-- Midnight
-- ============================================================
-- Known pool names from GatherMate2 Constants.lua:
--   "Bloom Swarm", "Blossoming Torrent", "Bubbling Bloom",
--   "Hunter Surge", "Lashing Waves", "Obscured School",
--   "Salmon Pool", "Song Swarm", "Sunbath School",
--   "Sunwell Swarm", "Surface Ripple"
-- Find uiMapIDs with:
--   /script print(C_Map.GetBestMapForUnit("player"))
-- then call addZonePools(ID, { "Pool Name", ... }) below.
