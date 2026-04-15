-- ============================================================
-- Poolepedia – Catch Tracker
-- Listens for fishing loot events and records what the player
-- catches from each known pool into PoolepediaCatches.
--
-- Poolepedia_LastPool is set by the tooltip hook in Poolepedia.lua
-- as { name = poolName, zoneID = zoneID }.
-- Catch data is keyed as "zoneID/poolName" to prevent collisions
-- when the same pool name exists in multiple zones.
--
-- Poolepedia_LastPool is cleared when the player moves, so casts
-- made while walking away from a pool are not attributed to it.
-- ============================================================
PoolepediaSessionCatches = {}  -- in-memory cache of catches for the current session; merged into PoolepediaCatches on logout

local trackerFrame = CreateFrame("Frame")
trackerFrame:RegisterEvent("LOOT_READY")
trackerFrame:RegisterEvent("PLAYER_STARTED_MOVING")

trackerFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_STARTED_MOVING" then
            Poolepedia_LastPool = nil
    elseif event == "LOOT_READY" then
        if not IsFishingLoot()      then return end
        if not Poolepedia_LastPool  then return end
        if not PoolepediaCatches    then return end

        local poolName = Poolepedia_LastPool.name
        local zoneID   = Poolepedia_LastPool.zoneID
        local catchKey = zoneID .. "/" .. poolName

        if not PoolepediaCatches[catchKey] then
            PoolepediaCatches[catchKey] = {}
        end

        -- Identify the current character (Name-Realm)
        local charKey = UnitName("player") .. "-" .. GetRealmName()

        for i = 1, GetNumLootItems() do
            local icon, itemName, quantity, _, quality = GetLootSlotInfo(i)
            local link = GetLootSlotLink(i)
            if link then
                local name = C_Item.GetItemInfo(link)
                if name then
                    local n = quantity or 1

                    -- Lifetime catches (persists in saved variables)
                    local catches = PoolepediaCatches[catchKey]
                    if not catches[itemName] then
                        catches[itemName] = { total = 0, icon = icon, byChar = {} }
                    end

                    -- migrate old entried that still use 'count'
                    if catches[itemName].count and not catches[itemName].total then
                        catches[itemName].total = catches[itemName].count
                        catches[itemName].count = nil
                        catches[itemName].byChar = catches[itemName].byChar or {}
                    end
                    catches[itemName].total = catches[itemName].total + n
                    
                    if not catches[itemName].byChar then catches[itemName].byChar = {} end
                    catches[itemName].byChar[charKey] = (catches[itemName].byChar[charKey] or 0) + n
                    
                    -- Session in memory table (resets on login)
                    if not PoolepediaSessionCatches[catchKey] then
                        PoolepediaSessionCatches[catchKey] = {}
                    end
                    local sc = PoolepediaSessionCatches[catchKey]
                    if not sc[itemName] then
                        sc[itemName] = { count = 0, icon = icon }
                    end
                    sc[itemName].count = sc[itemName].count + n
                end
            end
        end
        if Poolepedia_RefreshLiveStats then Poolepedia_RefreshLiveStats() end
    end
end)
