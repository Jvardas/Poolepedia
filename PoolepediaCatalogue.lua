-- ============================================================
-- Poolepedia - Catalogue Panel
-- Tabbed frame: Tab 1 = Fish Catalogue, Tab 2 = Settings
-- Opened via /pld or the minimap button
-- ============================================================

local FRAME_W = 720
local FRAME_H = 720
local LIST_W = 210
local ROW_H = 22

local frame = CreateFrame("Frame", "PoolepediaCatalogueFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(FRAME_W, FRAME_H)
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetToplevel(true)
frame:Hide()
table.insert(UISpecialFrames, "PoolepediaCatalogueFrame")

do
    local t = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    t:SetPoint("TOP", frame, "TOP", 0, -3)
    t:SetText("Poolepedia")
end

local function MakeTabBtn(name, label, anchor, anchorTo, anchorPoint, ox, oy)
    local b = CreateFrame("Button", name, frame, "UIPanelButtonTemplate")
    b:SetSize(100, 22)
    b:SetPoint(anchor, anchorTo, anchorPoint, ox, oy)
    local bg = b:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetVertexColor(0.12, 0.12, 0.12, 0.9)
    b._bg = bg
    local txt = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt:SetAllPoints()
    txt:SetText(label)
    b._txt = txt
    return b
end

local tab1 = MakeTabBtn("PoolepediaCatalogueTab1", "Catalogue", "BOTTOMLEFT", frame, "BOTTOMLEFT", 5, -22)
local tab2 = MakeTabBtn("PoolepediaCatalogueTab2", "Settings", "LEFT", tab1, "RIGHT", 2, 0)

local catPane = CreateFrame("Frame", nil, frame)
catPane:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -40)
catPane:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -8, 24)

local settingsPane = CreateFrame("Frame", nil, frame)
settingsPane:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -40)
settingsPane:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -8, 24)
settingsPane:Hide()

local function SwitchTab(n)
    catPane:SetShown(n == 1)
    settingsPane:SetShown(n == 2)
end
tab1:SetScript("OnClick", function() SwitchTab(1) end)
tab2:SetScript("OnClick", function() SwitchTab(2) end)
SwitchTab(1)

-- ============================================================
-- TAB 1: CATALOOGUE
-- ============================================================
local leftScroll = CreateFrame("ScrollFrame", nil, catPane, "UIPanelScrollFrameTemplate")
leftScroll:SetPoint("TOPLEFT", catPane, "TOPLEFT", 0, 0)
leftScroll:SetPoint("BOTTOMLEFT", catPane, "BOTTOMLEFT", 0, 0)
leftScroll:SetWidth(LIST_W - 24)

local leftList = CreateFrame("Frame", nil, leftScroll)
leftList:SetWidth(LIST_W - 20)
leftList:SetHeight(1)
leftScroll:SetScrollChild(leftList)

leftScroll:SetScript("OnSizeChanged", function(self)
    leftList:SetWidth(self:GetWidth())
end)

local div = catPane:CreateTexture(nil, "ARTWORK")
div:SetTexture("Interface\\Buttons\\WHITE8X8")
div:SetVertexColor(0.25, 0.25, 0.25, 1)
div:SetWidth(1)
div:SetPoint("TOPLEFT", catPane, "TOPLEFT", LIST_W, 0)
div:SetPoint("BOTTOMLEFT", catPane, "BOTTOMLEFT", LIST_W, 0)

local rightFrame = CreateFrame("Frame", nil, catPane)
rightFrame:SetPoint("TOPLEFT", catPane, "TOPLEFT", LIST_W+8, 0)
rightFrame:SetPoint("BOTTOMRIGHT", catPane, "BOTTOMRIGHT", 0, 0)

local fishHeader = rightFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
fishHeader:SetPoint("TOPLEFT", rightFrame, "TOPLEFT", 6, -4)
fishHeader:SetJustifyH("LEFT")
fishHeader:SetText("Select a fish ->")

local rightScroll = CreateFrame("ScrollFrame", nil, rightFrame, "UIPanelScrollFrameTemplate")
rightScroll:SetPoint("TOPLEFT", rightFrame, "TOPLEFT", 0, -26)
rightScroll:SetPoint("BOTTOMRIGHT", rightFrame, "BOTTOMRIGHT", -24, 0)

local rightList = CreateFrame("Frame", nil, rightScroll)
rightList:SetWidth(400)
rightList:SetHeight(1)
rightScroll:SetScrollChild(rightList)

rightScroll:SetScript("OnSizeChanged", function(self)
    rightList:SetWidth(self:GetWidth())
end)

-- ============================================
-- Accordion engine
-- ============================================
local HEADER_H = 26
local POOL_H = 20
local STAT_H = 22
local SUBROW_H = 18
local allSections = {}

local function RelayoutAll()
    local y = 0
    for _, sec in ipairs(allSections) do
        sec.hdrFrame:ClearAllPoints()
        sec.hdrFrame:SetPoint("TOPLEFT", rightList, "TOPLEFT", 0, -y)
        sec.hdrFrame:SetPoint("TOPRIGHT", rightList, "TOPRIGHT", 0, -y)
        sec.hdrFrame:Show()
        y = y + HEADER_H
        for _, row in ipairs(sec.rows) do
            if sec.expanded then
                row:ClearAllPoints()
                row:SetPoint("TOPLEFT", rightList, "TOPLEFT", 0, -y)
                row:SetPoint("TOPRIGHT", rightList, "TOPRIGHT", 0, -y)
                row:Show()
                y = y + POOL_H
            else
                row:Hide()
            end
        end
    end
    rightList:SetHeight(math.max(y, 1))
end

local function ClearRightPanel()
    for _, sec in ipairs(allSections) do
        sec.hdrFrame:Hide()
        sec.hdrFrame:SetParent(nil)
        for _, row in ipairs(sec.rows) do
            row:Hide()
            row:SetParent(nil)
        end
    end
    allSections = {}
end

local function MakeSectionHeader(label, r, g, b)
   local hdr = CreateFrame("Frame", nil, rightList)
    hdr:SetHeight(HEADER_H)

    local hbg = hdr:CreateTexture(nil, "BACKGROUND")
    hbg:SetAllPoints()
    hbg:SetTexture("Interface\\Buttons\\WHITE8X8")
    hbg:SetVertexColor(0.10, 0.10, 0.10, 0.95)

    local arrow = hdr:CreateTexture(nil, "OVERLAY")
    arrow:SetSize(16, 16)
    arrow:SetPoint("LEFT", hdr, "LEFT", 5, 0)
    arrow:SetTexture("Interface\\Buttons\\UI-PlusButton-Up")

    local lbl = hdr:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lbl:SetPoint("LEFT", hdr, "LEFT", 24, 0)
    lbl:SetPoint("RIGHT", hdr, "RIGHT", -4, 0)
    lbl:SetJustifyH("LEFT")
    lbl:SetText(label)
    lbl:SetTextColor(r, g, b)

    local sec = { hdrFrame = hdr, rows = {}, expanded = false, arrow = arrow }
    allSections[#allSections+1] = sec

    local function toggle()
        sec.expanded = not sec.expanded

        arrow:SetTexture(sec.expanded and "Interface\\Buttons\\UI-MinusButton-Up" or "Interface\\Buttons\\UI-PlusButton-Up")
        RelayoutAll()
    end

    hdr:EnableMouse(true)
    hdr:SetScript("OnMouseDown", function(_, btn)
        if btn == "LeftButton" then toggle() end
    end)
    hdr:SetScript("OnEnter", function() hbg:SetVertexColor(0.18, 0.18, 0.18, 0.95) end)
    hdr:SetScript("OnLeave", function() hbg:SetVertexColor(0.10, 0.10, 0.10, 0.95) end)
    return sec
end

-- ======================================
-- Section builders
-- ======================================
local function BuildMapsSection(fishName)
    local sec = MakeSectionHeader(" Maps", 1, 0.82, 0) -- gold

    local entries = PoolepediaFishIndex and PoolepediaFishIndex[fishName]
    if not entries then
        rightList:SetHeight(1)
        --ShowFishStats(fishName)
        return
    end

    for _, e in ipairs(entries) do
        local zrow = CreateFrame("Frame", nil, rightList)
        zrow:SetHeight(POOL_H)
        zrow._h = POOL_H + 2

        local zbg = zrow:CreateTexture(nil, "BACKGROUND")
        zbg:SetAllPoints()
        zbg:SetTexture("Interface\\Buttons\\WHITE8X8")
        zbg:SetVertexColor(0.14, 0.14, 0.14, 0.85)
        zrow:SetScript("OnEvent", function() zbg:SetVertexColor(1, 1, 1, 0.07) end)
        zrow:SetScript("OnLeave", function() zbg:SetVertexColor(1, 1, 1, 0) end)

        local zlbl = zrow:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        zlbl:SetPoint("LEFT", zrow, "LEFT", 10, 0)
        zlbl:SetPoint("RIGHT", zrow, "RIGHT", -54, 0)
        zlbl:SetJustifyH("LEFT")
        zlbl:SetText("|cFFFFD700" .. e.zoneName .. "|r  |cFF888888- " .. e.poolName .. "|r")

        local mapBtn = CreateFrame("Button", nil, zrow, "UIPanelButtonTemplate")
        mapBtn:SetSize(46, POOL_H - 2)
        mapBtn:SetPoint("RIGHT", zrow, "RIGHT", -2, 0)
        mapBtn:SetText("Map")
        local zoneID = e.zoneID
        mapBtn:SetScript("OnClick", function() OpenWorldMap(zoneID) end)

        zrow:Hide()
        sec.rows[#sec.rows+1] = zrow
    end

    return sec
end

local function BuildRecipesSection(fishName)
    local sec = MakeSectionHeader(" Recipes", 0, 0.85, 1) -- cyan

    local placeholder = CreateFrame("Frame", nil, rightList)
    placeholder:SetHeight(STAT_H)
    placeholder._h = STAT_H

    local plbl = placeholder:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    plbl:SetPoint("LEFT", placeholder, "LEFT", 14, 0)
    plbl:SetPoint("RIGHT", placeholder, "RIGHT", -4, 0)
    plbl:SetJustifyH("LEFT")
    plbl:SetTextColor(0.5, 0.5, 0.5)
    plbl:SetText("Crafting data not available")

    placeholder:Hide()
    sec.rows[#sec.rows+1] = placeholder

    return sec
end

local function BuildStatsSection(fishName)
    local sec = MakeSectionHeader(" Lifetime Stats", 0, 0.65, 1) -- blue
    
    -- Aggregate lifetime catches across every pool entry for this fish.
    -- totals[itemName] = { total = N, icon = "...", byChar = { ["Name-Realm"] = N }}
    local totals = {}
    local entries = PoolepediaFishIndex and PoolepediaFishIndex[fishName]
    if entries then
        for _, e in ipairs(entries) do
            local key = e.zoneID .. "/" .. e.poolName
            local catches = PoolepediaCatches and PoolepediaCatches[key]
            if catches then
                for itemName, catchData in pairs(catches) do
                    if not totals[itemName] then
                        totals[itemName] = { total = 0, icon = catchData.icon, byChar = {} }
                    end
                    local t = totals[itemName]
                    t.total = t.total + (catchData.total or catchData.count or 0)
                    -- merge per char sub-totals
                    if catchData.byChar then
                        for char, n in pairs(catchData.byChar) do
                            t.byChar[char] = (t.byChar[char] or 0) + n
                        end
                    end
                end
            end
        end
    end

    local sorted = {}
    for n, d in pairs(totals) do sorted[#sorted+1] = { name = n, total = d.total, icon = d.icon, byChar = d.byChar } end
    table.sort(sorted, function(a, b) return a.total > b.total end)

    if #sorted == 0 then
        local empty = CreateFrame("Frame", nil, rightList)
        empty:SetHeight(STAT_H)
        empty._h = STAT_H
        
        local elbl = empty:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        elbl:SetPoint("LEFT", empty, "LEFT", 14, 0)
        elbl:SetPoint("RIGHT", empty, "RIGHT", -4, 0)
        elbl:SetJustifyH("LEFT")
        elbl:SetTextColor(0.5, 0.5, 0.5)
        elbl:SetText("No catches recorded yet")

        empty:Hide()
        sec.rows[#sec.rows+1] = empty
        return sec
    end

    for _, item in ipairs(sorted) do
        -- Item row
        local row = CreateFrame("Frame", nil, rightList)
        row:SetHeight(STAT_H)
        row._h = STAT_H

        local iconTex = row:CreateTexture(nil, "ARTWORK")
        iconTex:SetSize(16, 16)
        iconTex:SetPoint("LEFT", row, "LEFT", 10, 0)
        if item.icon then iconTex:SetTexture(item.icon) end

        local lbl = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        lbl:SetPoint("LEFT", row, "LEFT", 30, 0)
        lbl:SetPoint("RIGHT", row, "RIGHT", -60, 0)
        lbl:SetJustifyH("LEFT")
        lbl:SetText(item.name)

        local cnt = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        cnt:SetPoint("RIGHT", row, "RIGHT", -4, 0)
        cnt:SetJustifyH("RIGHT")
        cnt:SetText("|cFFFFD700x" .. item.total .. "|r")

        row:Hide()
        sec.rows[#sec.rows + 1] = row

        -- Per-character sub-rows (only when >=2 characters have data)
        local charList = {}
        for char, n in pairs(item.byChar) do
            charList[#charList+1] = { char = char, n = n }
        end
        table.sort(charList, function(a, b) return a.n > b.n end)

        if #charList >= 1 then
            for _, cd in ipairs(charList) do
                local sub = CreateFrame("Frame", nil, rightList)
                sub:SetHeight(SUBROW_H)
                sub._h = SUBROW_H

                local classToken = PoolepediaCharClasses and PoolepediaCharClasses[cd.char]
                local cr, cg, cb = 0.6, 0.6, 0.6
                if classToken and RAID_CLASS_COLORS and RAID_CLASS_COLORS[classToken] then
                    local c = RAID_CLASS_COLORS[classToken]
                    if c then
                        cr, cg, cb = c.r, c.g, c.b
                    end
                end

                local subLbl = sub:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                subLbl:SetPoint("LEFT", sub, "LEFT", 34, 0)
                subLbl:SetPoint("RIGHT", sub, "RIGHT", -60, 0)
                subLbl:SetJustifyH("LEFT")
                subLbl:SetTextColor(cr, cg, cb)
                subLbl:SetText("" .. cd.char)

                local subCnt = sub:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                subCnt:SetPoint("RIGHT", sub, "RIGHT", -4, 0)
                subCnt:SetJustifyH("RIGHT")
                subCnt:SetTextColor(0.6, 0.6, 0.6)
                subCnt:SetText("x" .. cd.n)

                sub:Hide()
                sec.rows[#sec.rows+1] = sub
            end
        end
    end
    
    return sec
end

local activeCatalogueFish = nil

local function ShowFishZones(fishName)
    activeCatalogueFish = fishName
    fishHeader:SetText(fishName)
    ClearRightPanel()

    BuildMapsSection(fishName)
    BuildRecipesSection(fishName)
    BuildStatsSection(fishName)

    RelayoutAll()
end

Poolepedia_RefreshLiveStats = function()
    if activeCatalogueFish then ShowFishZones(activeCatalogueFish) end
end

-- Fish list buttons ------------------------------------------------------
local fishButtons = {}
local activeBtn = nil

local function DeactivateAll()
    for _, b in ipairs(fishButtons) do
        b._bg:SetVertexColor(1, 1, 1, 0)
    end
    activeBtn = nil
end

local function RefreshFishColors()
    for _, btn in ipairs(fishButtons) do
        local exp
        local entries = PoolepediaFishIndex and PoolepediaFishIndex[btn._name]
        if entries and entries[1] then
            local pd = PoolepediaDB and PoolepediaDB._byName[entries[1].poolName]
            exp = pd and pd.expansion
        end
        local enabled = not exp
            or not PoolepediaSettings
            or PoolepediaSettings[exp] ~= false
        local r = enabled and 1 or 0.38
        btn._lbl:SetTextColor(r, r, r)
        if btn._icon then btn._icon:SetAlpha(enabled and 1 or 0.38) end
        if btn == activeBtn then
            btn._bg:SetVertexColor(0.2, 0.55, 1, 0.30)
        end
    end
end
Poolepedia_RefreshCatalogueList = RefreshFishColors

local fishListBuilt = false
local function BuildFishList()
    if fishListBuilt then return end
    if not PoolepediaFishIndex then return end

    local names = {}
    for n in pairs(PoolepediaFishIndex) do
        names[#names+1] = n
    end
    table.sort(names)

    local y = 0
    for _, name in ipairs(names) do
        local btn = CreateFrame("Button", nil, leftList)
        btn:SetHeight(ROW_H)
        btn:SetPoint("TOPLEFT", leftList, "TOPLEFT", 2, -y)
        btn:SetPoint("TOPRIGHT", leftList, "TOPRIGHT", -2, -y)

        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture("Interface\\Buttons\\WHITE8X8")
        bg:SetVertexColor(1, 1, 1, 0)

        local iconTex = btn:CreateTexture(nil, "ARTWORK")
        iconTex:SetSize(16, 16)
        iconTex:SetPoint("LEFT", btn, "LEFT", 4, 0)
        local _, _, _, _, _, _, _, _, _, tex = C_Item.GetItemInfo(name)
        if tex then
            iconTex:SetTexture(tex)
        else
            iconTex:SetTexture("Interface\\Icons\\INV_MISC_QUESTIONMARK")
        end

        local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        lbl:SetPoint("LEFT", btn, "LEFT", 24, 0)
        lbl:SetPoint("RIGHT", btn, "RIGHT", -2, 0)
        lbl:SetJustifyH("LEFT")
        lbl:SetText(name)

        btn._name = name
        btn._bg = bg
        btn._lbl = lbl
        btn._icon = iconTex

        btn:SetScript("OnEnter", function (self)
            if self ~= activeBtn then bg:SetVertexColor(1, 1, 1, 0.88) end
        end)
        btn:SetScript("OnLeave", function (self)
            if self ~= activeBtn then bg:SetVertexColor(1, 1, 1, 0) end
        end)
        btn:SetScript("OnClick", function (self)
            DeactivateAll()
            activeBtn = self
            bg:SetVertexColor(0.2, 0.55, 1, 0.38)
            ShowFishZones(name)
        end)

        fishButtons[#fishButtons+1] = btn
        y = y + ROW_H
    end
    leftList:SetHeight(math.max(y, 1))
    fishListBuilt = true
end

local iconByName = {}
local iconFillFrame = CreateFrame("Frame")
iconFillFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
iconFillFrame:SetScript("OnEvent", function(_, _, itemID, success)
    if not success then return end
    if not fishListBuilt then return end
    for _, btn in ipairs(fishButtons) do
        if not btn._icon then
            local _, _, _, _, _, _, _, _, _, tex = C_Item.GetItemInfo(btn._name)
            if tex then
                btn._icon:SetTexture(tex)
            end
        end
    end
end)

catPane:SetScript("OnShow", function()
    BuildFishList()
    RefreshFishColors()
end)

-- Search box --------------------------------------------------------------------------
-- Search box with styling and clear button
local searchContainer = CreateFrame("Frame", nil, catPane)
searchContainer:SetPoint("TOPLEFT", catPane, "TOPLEFT", 0, 0)
searchContainer:SetSize(LIST_W - 16, 28)

local searchBox = CreateFrame("EditBox", nil, searchContainer, "InputBoxTemplate")
searchBox:SetPoint("TOPLEFT", searchContainer, "TOPLEFT", 4, -2)
searchBox:SetSize(LIST_W - 40, 20)
searchBox:SetAutoFocus(false)
searchBox:SetText("")

-- Clear button
local clearBtn = CreateFrame("Button", nil, searchContainer)
clearBtn:SetSize(20, 20)
clearBtn:SetPoint("RIGHT", searchContainer, "RIGHT", -2, 0)
local clearTex = clearBtn:CreateTexture(nil, "ARTWORK")
clearTex:SetTexture("Interface\\Icons\\INV_MISC_QUESTIONMARK")
clearTex:SetAllPoints()
clearBtn:SetScript("OnClick", function()
    searchBox:SetText("")
    searchBox:ClearFocus()
end)
clearBtn:SetScript("OnEnter", function()
    GameTooltip:SetOwner(clearBtn, "ANCHOR_RIGHT")
    GameTooltip:AddLine("Clear search", 1, 1, 1)
    GameTooltip:Show()
end)
clearBtn:SetScript("OnLeave", GameTooltip_Hide)

-- Enhanced search with highlighting
searchBox:SetScript("OnTextChanged", function(self)
    local query = self:GetText():lower()
    local visibleY = 0
    
    for _, btn in ipairs(fishButtons) do
        local fishName = btn._name
        local match = query == "" or fishName:lower():find(query, 1, true)
        btn:SetShown(match)
        
        if match then
            btn:SetPoint("TOPLEFT", leftList, "TOPLEFT", 2, -visibleY)
            
            -- Highlight matching text
            if query ~= "" then
                local lowerName = fishName:lower()
                local start, end_ = lowerName:find(query, 1, true)
                if start then
                    local before = fishName:sub(1, start - 1)
                    local matched = fishName:sub(start, end_)
                    local after = fishName:sub(end_ + 1)
                    btn._lbl:SetText(before .. "|cFFFFD700" .. matched .. "|r" .. after)
                else
                    btn._lbl:SetText(fishName)
                end
            else
                btn._lbl:SetText(fishName)
            end
            
            visibleY = visibleY + ROW_H
        end
    end
    
    leftList:SetHeight(math.max(visibleY, 1))
end)

-- Adjust leftScroll to account for search box
leftScroll:SetPoint("TOPLEFT", searchContainer, "BOTTOMLEFT", 0, -4)

-- ============================================================
-- TAB 2: SETTINGS
-- ============================================================
local ROW_H_S = 26
local SETTINGS_DIVIDER = 350  -- x position of divider

local settingsLbl = settingsPane:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
settingsLbl:SetPoint("TOPLEFT", settingsPane, "TOPLEFT", 8, -8)
settingsLbl:SetText("Show pool tooltip for expansion:")
settingsLbl:SetTextColor(0.7, 0.7, 0.7)

local settingsCBs = {}
for i, exp in ipairs(Poolepedia_EXPANSIONS) do
    local cb = CreateFrame("CheckButton", "PoolepediaCatCB" .. i, settingsPane, "UICheckButtonTemplate")
    cb:SetPoint("TOPLEFT", settingsPane, "TOPLEFT", 8, -24 - (i * ROW_H_S))
    cb:SetScript("OnClick", function(self)
        if PoolepediaSettings then
            PoolepediaSettings[exp] = self:GetChecked()
        end
        -- if Poolepedia_RefreshMapPanel then Poolepedia_RefreshMapPanel() end -- TODO REMOVE
        if Poolepedia_RefreshCatalogueList then Poolepedia_RefreshCatalogueList() end
    end)
    cb.text:SetText(exp)
    settingsCBs[exp] = cb
end

local divider = settingsPane:CreateTexture(nil, "ARTWORK")
divider:SetTexture("Interface\\Buttons\\WHITE8X8")
divider:SetVertexColor(0.25, 0.25, 0.25, 1)
divider:SetWidth(1)
divider:SetPoint("TOPLEFT", settingsPane, "TOPLEFT", SETTINGS_DIVIDER, 0)
divider:SetPoint("BOTTOMLEFT", settingsPane, "BOTTOMLEFT", SETTINGS_DIVIDER, 0)

-- Minimap button toggle
local minimapLbl = settingsPane:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
minimapLbl:SetPoint("TOPLEFT", settingsPane, "TOPLEFT", SETTINGS_DIVIDER + 16, -8)
minimapLbl:SetText("UI Settings:")
minimapLbl:SetTextColor(0.7, 0.7, 0.7)

local minimapCB = CreateFrame("CheckButton", "PoolepediaCatMinimapCB", settingsPane, "UICheckButtonTemplate")
minimapCB:SetPoint("TOPLEFT", settingsPane, "TOPLEFT", SETTINGS_DIVIDER + 16, -28)
minimapCB:SetScript("OnClick", function(self)
    if PoolepediaSettings then
        PoolepediaSettings.hideMinimapButton = not self:GetChecked()
    end
    if Poolepedia_RefreshMinimapButton then
        Poolepedia_RefreshMinimapButton()
    end
end)
minimapCB.text:SetText("Show minimap button")

settingsPane:SetScript("OnShow", function()
    -- Minimap button checkbox
    minimapCB:SetChecked(not (PoolepediaSettings and PoolepediaSettings.hideMinimapButton))
    -- Expansion checkboxes
    for exp, cb in pairs(settingsCBs) do
        cb:SetChecked(PoolepediaSettings == nil or PoolepediaSettings[exp] ~= false)
    end
end)

-- ============================================================
-- Slash Command  /pld  – toggles the settings panel
-- ============================================================
SLASH_POOLEPEDIA1 = "/pld"
SlashCmdList["POOLEPEDIA"] = function()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end