-- ============================================================
-- Poolepedia
-- Enhances fishing pool tooltips with catchable fish info.
-- Author: RetroLizard
-- ============================================================

local ADDON_NAME = "Poolepedia"

-- ============================================================
-- Expansion list
-- Controls display order in the settings UI.
-- Exposed as a global so PoolepediaSettings.lua can read it.
-- ============================================================
Poolepedia_EXPANSIONS = {
    "Classic",
    "The Burning Crusade",
    "Wrath of the Lich King",
    "Cataclysm",
    "Mists of Pandaria",
    "Warlords of Draenor",
    "Legion",
    "Battle for Azeroth",
    "Shadowlands",
    "Dragonflight",
    "The War Within",
    "Midnight",
}

-- ============================================================
-- Saved Variables
-- PoolepediaSettings is persisted via SavedVariables in the TOC.
-- ============================================================
local function GetDefaults()
    local d = {}
    for _, exp in ipairs(Poolepedia_EXPANSIONS) do
        d[exp] = true
    end
    return d
end

-- ============================================================
-- Initialise saved variables on load
-- ============================================================
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function(self, event, loadedAddon)
    -- PLAYER_LOGIN
    if event == "PLAYER_LOGIN" then
        if type(PoolepediaCharClasses) ~= "table" then
            PoolepediaCharClasses = {}
        end
        local playerName = UnitName("player")
        local realmName = GetRealmName()
        if playerName and realmName then
            local charKey = playerName .. "-" .. realmName
            local _, classToken = UnitClass("player")
            if classToken then
                PoolepediaCharClasses[charKey] = classToken
            end 
        end
        self:UnregisterEvent("PLAYER_LOGIN")
        return
    end

    -- ADDON LOADED
    if loadedAddon ~= ADDON_NAME then return end

    if type(PoolepediaSettings) ~= "table" then
        PoolepediaSettings = GetDefaults()
    else
        -- Back-fill keys added by future updates (e.g. Midnight)
        local defaults = GetDefaults()
        for exp, val in pairs(defaults) do
            if PoolepediaSettings[exp] == nil then
                PoolepediaSettings[exp] = val
            end
        end
        if PoolepediaSettings.minimapAngle == nil then
            PoolepediaSettings.minimapAngle = 225
        end
    end

    if type(PoolepediaCatches) ~= "table" then
        PoolepediaCatches = {}
    else
        -- Migrate 1: zone scoped keys (old: Pool Name, new: "zoneID/Pool Name"
        local toMigrate = {}
        for k in pairs(PoolepediaCatches) do
            if not k:find("/", 1, true) then
                toMigrate[k] = PoolepediaCatches[k]
            end
        end
        if next(toMigrate) then
            for k in pairs(toMigrate) do
                PoolepediaCatches[k] = nil
            end
            print("|cFF00CCFFPoolepedia|r: Catch history was reset due to a format upgrade (zone-aware keys).")
        end
    end

    -- Migrate 2: per-item format (old: { count, icon }, new { total, icon, byChar })
    local migratedCount = 0
    for _, itemTable in pairs(PoolepediaCatches) do
        if type(itemTable) == "table" then
            for _, entry in pairs(itemTable) do
                if type(entry) == "table" then
                    if entry.count and not entry.total then
                        entry.total = entry.count
                        entry.count = nil
                        entry.byChar = entry.byChar or {}
                        migratedCount = migratedCount + 1
                    elseif entry.total and not entry.byChar then
                        entry.byChar = {}
                        migratedCount = migratedCount + 1
                    end
                end
            end
        end
    end
    if migratedCount > 0 then
        print("|cFF00CCFFPoolepedia|r: Catch data upgraded to per-character format (" .. migratedCount .. " entries). Log in with each character to start breakdowns.")
    end
    self:UnregisterEvent("ADDON_LOADED")
end)

-- ============================================================
-- Tooltip Hook
-- ============================================================
local function Poolepedia_OnGameObjectTooltip(tooltip, data)
    local name
    if data and type(data) == "table" and data.name then
        name = data.name
    elseif GameTooltipTextLeft1 then
        name = GameTooltipTextLeft1:GetText()
    end
    if not name then return end

    -- Look up pool data (name-primary; the fish list is what we own)
    local poolInfo = PoolepediaDB._byName[name]
    if not poolInfo then return end

    -- Zone filter: check whether this pool is known in the player's zone.
    -- Falls back to showing the tooltip when the zone isn't in our DB yet
    -- (e.g. fresh Midnight zones) so the addon remains useful on day one.
    local zoneID     = C_Map.GetBestMapForUnit("player")
    local zoneKnown  = PoolepediaZones[zoneID] ~= nil
    local poolInZone = zoneKnown and PoolepediaZones[zoneID][name]
    local fallback   = not zoneKnown and PoolepediaZones._byName[name]

    if zoneKnown and not poolInZone then
        -- Zone is in our DB but this pool is not listed there — skip.
        return
    end

    -- Respect per-expansion setting
    if PoolepediaSettings and PoolepediaSettings[poolInfo.expansion] == false then
        return
    end
    
    -- Mark the active pool for PoolepediaTracker.lua
    Poolepedia_LastPool = { name = name, zoneID = zoneID }
    tooltip:AddLine(" ")
    tooltip:AddLine("|cFF00CCFFPoolepedia|r")

    if fallback then
        tooltip:AddLine("Zone data not yet available", 0.6, 0.6, 0.6)
    end

    tooltip:AddLine("Can catch:", 1, 0.82, 0)
    for _, fishName in ipairs(poolInfo.fish) do
        tooltip:AddLine("  |cFFFFFFFF" .. fishName .. "|r")
    end
    if poolInfo.notes then
        tooltip:AddLine(poolInfo.notes, 0.6, 0.6, 0.6)
    end

    local catchKey = zoneID .. "/" .. name
    local catches  = PoolepediaSessionCatches and PoolepediaSessionCatches[catchKey]
    if catches and next(catches) then
        tooltip:AddLine(" ")
        tooltip:AddLine("Session catches:", 0, 0.8, 1)
        for itemName, catchData in pairs(catches) do
            tooltip:AddDoubleLine(
                "  |T" .. catchData.icon .. ":16|t " .. itemName,
                "x" .. catchData.count,
                1, 1, 1,
                1, 0.82, 0
            )
        end
    end

    tooltip:Show()
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Object, Poolepedia_OnGameObjectTooltip)
