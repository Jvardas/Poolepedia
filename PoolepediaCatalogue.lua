-- ============================================================
-- Poolepedia - Catalogue Panel
-- Tabbed frame: Tab 1 = Fish Catalogue, Tab 2 = Settings
-- Opened via /pld or the minimap button
-- ============================================================

local FRAME_W  = 720
local FRAME_H  = 720
local LIST_W   = 210
local ROW_H    = 22
local HEADER_H = 44   -- top strip height (title + tabs)

-- ============================================================
-- Main frame  – plain dark panel, no WoW chrome
-- ============================================================
local frame = CreateFrame("Frame", "PoolepediaCatalogueFrame", UIParent, "BackdropTemplate")
frame:SetSize(FRAME_W, FRAME_H)
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetToplevel(true)
frame:SetFrameStrata("DIALOG")
frame:Hide()
table.insert(UISpecialFrames, "PoolepediaCatalogueFrame")

-- Dark semi-transparent body
frame:SetBackdrop({
    bgFile   = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 16,
    insets   = { left = 4, right = 4, top = 4, bottom = 4 },
})
frame:SetBackdropColor(0.04, 0.04, 0.04, 0.82)
frame:SetBackdropBorderColor(0.22, 0.22, 0.22, 1)

-- ── Header strip ────────────────────────────────────────────
local header = CreateFrame("Frame", nil, frame)
header:SetPoint("TOPLEFT",  frame, "TOPLEFT",  0, 0)
header:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
header:SetHeight(HEADER_H)

local headerBg = header:CreateTexture(nil, "BACKGROUND")
headerBg:SetAllPoints()
headerBg:SetTexture("Interface\\Buttons\\WHITE8X8")
headerBg:SetVertexColor(0.06, 0.06, 0.06, 1)

-- Thin separator below header
local headerLine = header:CreateTexture(nil, "ARTWORK")
headerLine:SetTexture("Interface\\Buttons\\WHITE8X8")
headerLine:SetVertexColor(0.22, 0.22, 0.22, 1)
headerLine:SetHeight(1)
headerLine:SetPoint("BOTTOMLEFT",  header, "BOTTOMLEFT",  0, 0)
headerLine:SetPoint("BOTTOMRIGHT", header, "BOTTOMRIGHT", 0, 0)

-- Title text
local titleText = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
titleText:SetPoint("LEFT", header, "LEFT", 16, 0)
titleText:SetText("Poolepedia")
titleText:SetTextColor(0.9, 0.85, 0.65, 1)  -- warm gold

-- Close button
local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, 2)
closeBtn:SetScript("OnClick", function() frame:Hide() end)

-- ============================================================
-- ── Panes (content area below header) ───────────────────────
local catPane = CreateFrame("Frame", nil, frame)
catPane:SetPoint("TOPLEFT",     frame, "TOPLEFT",     8, -(HEADER_H + 6))
catPane:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -8, 8)

-- ============================================================
-- TAB 1: CATALOGUE
-- ============================================================

-- ── Expansion filter dropdown (UIDropDownMenuTemplate) ──────
local filterDropdown = CreateFrame("Frame", "PoolepediaFilterDropdown", catPane, "UIDropDownMenuTemplate")
filterDropdown:SetPoint("TOPLEFT", catPane, "TOPLEFT", -15, -4)
UIDropDownMenu_SetWidth(filterDropdown, LIST_W - 30)

local function UpdateFilterLabel()
    if not PoolepediaSettings then
        UIDropDownMenu_SetText(filterDropdown, "All Expansions")
        return
    end
    local allOn, count, last = true, 0, nil
    for _, exp in ipairs(Poolepedia_EXPANSIONS) do
        if PoolepediaSettings[exp] ~= false then
            count = count + 1
            last  = exp
        else
            allOn = false
        end
    end
    if allOn then
        UIDropDownMenu_SetText(filterDropdown, "All Expansions")
    elseif count == 1 then
        UIDropDownMenu_SetText(filterDropdown, last)
    else
        UIDropDownMenu_SetText(filterDropdown, "Multiple (" .. count .. ")")
    end
end

UIDropDownMenu_Initialize(filterDropdown, function(_, _)
    local info         = UIDropDownMenu_CreateInfo()
    info.text          = "All Expansions"
    info.notCheckable  = true
    info.func = function()
        if PoolepediaSettings then
            for _, exp in ipairs(Poolepedia_EXPANSIONS) do
                PoolepediaSettings[exp] = true
            end
        end
        UpdateFilterLabel()
        if Poolepedia_RefreshCatalogueList then Poolepedia_RefreshCatalogueList() end
    end
    UIDropDownMenu_AddButton(info)

    for _, exp in ipairs(Poolepedia_EXPANSIONS) do
        local info2            = UIDropDownMenu_CreateInfo()
        info2.text             = exp
        info2.isNotRadio       = true
        info2.keepShownOnClick = true
        info2.checked          = not PoolepediaSettings or PoolepediaSettings[exp] ~= false
        info2.func = function(btn)
            if PoolepediaSettings then PoolepediaSettings[exp] = btn.checked end
            UpdateFilterLabel()
            if Poolepedia_RefreshCatalogueList then Poolepedia_RefreshCatalogueList() end
        end
        UIDropDownMenu_AddButton(info2)
    end
end)

-- ── Search box ───────────────────────────────────────────────
local searchBox = CreateFrame("EditBox", "PoolepediaSearchBox", catPane, "SearchBoxTemplate")
searchBox:SetPoint("TOPLEFT", catPane, "TOPLEFT", 0, -36)
searchBox:SetSize(LIST_W - 24, 20)
searchBox:SetAutoFocus(false)

-- ── Left scroll / fish list ─────────────────────────────────
local leftScroll = CreateFrame("ScrollFrame", nil, catPane, "UIPanelScrollFrameTemplate")
leftScroll:SetPoint("TOPLEFT",    searchBox, "BOTTOMLEFT",  0,  -4)
leftScroll:SetPoint("BOTTOMLEFT", catPane,   "BOTTOMLEFT",  0,   0)
leftScroll:SetWidth(LIST_W - 24)

local leftList = CreateFrame("Frame", nil, leftScroll)
leftList:SetWidth(LIST_W - 20)
leftList:SetHeight(1)
leftScroll:SetScrollChild(leftList)

leftScroll:SetScript("OnSizeChanged", function(self)
    leftList:SetWidth(self:GetWidth())
end)

-- ── Vertical divider ────────────────────────────────────────
local div = catPane:CreateTexture(nil, "ARTWORK")
div:SetTexture("Interface\\Buttons\\WHITE8X8")
div:SetVertexColor(0.25, 0.25, 0.35, 1)
div:SetWidth(1)
div:SetPoint("TOPLEFT",    catPane, "TOPLEFT",    LIST_W, 0)
div:SetPoint("BOTTOMLEFT", catPane, "BOTTOMLEFT", LIST_W, 0)

-- ── Right panel ─────────────────────────────────────────────
local rightFrame = CreateFrame("Frame", nil, catPane)
rightFrame:SetPoint("TOPLEFT",     catPane, "TOPLEFT",     LIST_W + 8, 0)
rightFrame:SetPoint("BOTTOMRIGHT", catPane, "BOTTOMRIGHT", 0,          0)

local fishHeader = rightFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
fishHeader:SetPoint("TOPLEFT", rightFrame, "TOPLEFT", 6, -4)
fishHeader:SetJustifyH("LEFT")
fishHeader:SetText("Select a fish ->")

local rightScroll = CreateFrame("ScrollFrame", nil, rightFrame, "UIPanelScrollFrameTemplate")
rightScroll:SetPoint("TOPLEFT",     rightFrame, "TOPLEFT",     0,  -26)
rightScroll:SetPoint("BOTTOMRIGHT", rightFrame, "BOTTOMRIGHT", -10,   0)

local rightList = CreateFrame("Frame", nil, rightScroll)
rightList:SetWidth(400)
rightList:SetHeight(1)
rightScroll:SetScrollChild(rightList)

rightScroll:SetScript("OnSizeChanged", function(self)
    rightList:SetWidth(self:GetWidth())
end)

-- ── Slim scrollbar styling ───────────────────────────────────
local function StyleScrollBar(scrollFrame)
    local sb = scrollFrame.ScrollBar
    if not sb then return end

    sb:SetWidth(6)

    -- Dark track behind the thumb
    local track = sb:CreateTexture(nil, "BACKGROUND")
    track:SetAllPoints()
    track:SetTexture("Interface\\Buttons\\WHITE8X8")
    track:SetVertexColor(0.08, 0.08, 0.08, 0.85)

    -- Slim, light thumb
    local thumb = sb.ThumbTexture
    if thumb then
        thumb:SetWidth(4)
        thumb:SetTexture("Interface\\Buttons\\WHITE8X8")
        thumb:SetVertexColor(0.45, 0.45, 0.48, 0.90)
    end

    -- Minimal arrow buttons
    for _, btn in ipairs({ sb.ScrollUpButton, sb.ScrollDownButton }) do
        if btn then
            btn:SetSize(6, 10)
            for _, getter in ipairs({
                btn.GetNormalTexture,
                btn.GetHighlightTexture,
                btn.GetPushedTexture,
                btn.GetDisabledTexture,
            }) do
                local t = getter and getter(btn)
                if t then t:SetTexture("") end
            end
            local cap = btn:CreateTexture(nil, "ARTWORK")
            cap:SetAllPoints()
            cap:SetTexture("Interface\\Buttons\\WHITE8X8")
            cap:SetVertexColor(0.28, 0.28, 0.30, 0.85)
        end
    end
end

StyleScrollBar(leftScroll)
StyleScrollBar(rightScroll)

-- ============================================================
-- Accordion engine
-- ============================================================
local ACC_HEADER_H = 26
local POOL_H       = 20
local STAT_H       = 22
local SUBROW_H     = 18
local allSections  = {}

local function RelayoutAll()
    local y = 0
    for _, sec in ipairs(allSections) do
        sec.hdrFrame:ClearAllPoints()
        sec.hdrFrame:SetPoint("TOPLEFT",  rightList, "TOPLEFT",  0, -y)
        sec.hdrFrame:SetPoint("TOPRIGHT", rightList, "TOPRIGHT", 0, -y)
        sec.hdrFrame:Show()
        y = y + ACC_HEADER_H
        for _, row in ipairs(sec.rows) do
            if sec.expanded then
                row:ClearAllPoints()
                row:SetPoint("TOPLEFT",  rightList, "TOPLEFT",  0, -y)
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
    hdr:SetHeight(ACC_HEADER_H)

    local hbg = hdr:CreateTexture(nil, "BACKGROUND")
    hbg:SetAllPoints()
    hbg:SetTexture("Interface\\Buttons\\WHITE8X8")
    hbg:SetVertexColor(0.08, 0.08, 0.08, 0.95)

    local arrow = hdr:CreateTexture(nil, "OVERLAY")
    arrow:SetSize(16, 16)
    arrow:SetPoint("LEFT", hdr, "LEFT", 5, 0)
    arrow:SetTexture("Interface\\Buttons\\UI-PlusButton-Up")

    local lbl = hdr:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lbl:SetPoint("LEFT",  hdr, "LEFT",  24, 0)
    lbl:SetPoint("RIGHT", hdr, "RIGHT", -4, 0)
    lbl:SetJustifyH("LEFT")
    lbl:SetText(label)
    lbl:SetTextColor(r, g, b)

    local sec = { hdrFrame = hdr, rows = {}, expanded = false, arrow = arrow }
    allSections[#allSections + 1] = sec

    local function toggle()
        sec.expanded = not sec.expanded
        arrow:SetTexture(sec.expanded
            and "Interface\\Buttons\\UI-MinusButton-Up"
            or  "Interface\\Buttons\\UI-PlusButton-Up")
        RelayoutAll()
    end

    hdr:EnableMouse(true)
    hdr:SetScript("OnMouseDown", function(_, btn)
        if btn == "LeftButton" then toggle() end
    end)
    hdr:SetScript("OnEnter", function() hbg:SetVertexColor(0.14, 0.14, 0.14, 0.95) end)
    hdr:SetScript("OnLeave", function() hbg:SetVertexColor(0.08, 0.08, 0.08, 0.95) end)

    return sec
end

-- ============================================================
-- Section builders
-- ============================================================
local function BuildMapsSection(fishName)
    local sec = MakeSectionHeader(" Maps", 1, 0.82, 0)

    local entries = PoolepediaFishIndex and PoolepediaFishIndex[fishName]
    if not entries then
        rightList:SetHeight(1)
        return
    end

    for _, e in ipairs(entries) do
        local zrow = CreateFrame("Frame", nil, rightList)
        zrow:SetHeight(POOL_H)
        zrow._h = POOL_H + 2

        local zbg = zrow:CreateTexture(nil, "BACKGROUND")
        zbg:SetAllPoints()
        zbg:SetTexture("Interface\\Buttons\\WHITE8X8")
        zbg:SetVertexColor(0.12, 0.12, 0.16, 0.85)
        zrow:SetScript("OnEnter", function() zbg:SetVertexColor(0.18, 0.18, 0.25, 1) end)
        zrow:SetScript("OnLeave", function() zbg:SetVertexColor(0.12, 0.12, 0.16, 0.85) end)

        local zlbl = zrow:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        zlbl:SetPoint("LEFT",  zrow, "LEFT",   10, 0)
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
        sec.rows[#sec.rows + 1] = zrow
    end

    return sec
end

local function BuildRecipesSection(_)
    local sec = MakeSectionHeader(" Recipes", 0, 0.85, 1)

    local placeholder = CreateFrame("Frame", nil, rightList)
    placeholder:SetHeight(STAT_H)
    placeholder._h = STAT_H

    local plbl = placeholder:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    plbl:SetPoint("LEFT",  placeholder, "LEFT",   14, 0)
    plbl:SetPoint("RIGHT", placeholder, "RIGHT",  -4, 0)
    plbl:SetJustifyH("LEFT")
    plbl:SetTextColor(0.5, 0.5, 0.5)
    plbl:SetText("Crafting data not available")

    placeholder:Hide()
    sec.rows[#sec.rows + 1] = placeholder

    return sec
end

local function BuildStatsSection(fishName)
    local sec = MakeSectionHeader(" Lifetime Stats", 0, 0.65, 1)

    local totals = {}
    local entries = PoolepediaFishIndex and PoolepediaFishIndex[fishName]
    if entries then
        for _, e in ipairs(entries) do
            local key     = e.zoneID .. "/" .. e.poolName
            local catches = PoolepediaCatches and PoolepediaCatches[key]
            if catches then
                for itemName, catchData in pairs(catches) do
                    if not totals[itemName] then
                        totals[itemName] = { total = 0, icon = catchData.icon, byChar = {} }
                    end
                    local t = totals[itemName]
                    t.total = t.total + (catchData.total or catchData.count or 0)
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
    for n, d in pairs(totals) do
        sorted[#sorted + 1] = { name = n, total = d.total, icon = d.icon, byChar = d.byChar }
    end
    table.sort(sorted, function(a, b) return a.total > b.total end)

    if #sorted == 0 then
        local empty = CreateFrame("Frame", nil, rightList)
        empty:SetHeight(STAT_H)
        empty._h = STAT_H

        local elbl = empty:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        elbl:SetPoint("LEFT",  empty, "LEFT",   14, 0)
        elbl:SetPoint("RIGHT", empty, "RIGHT",  -4, 0)
        elbl:SetJustifyH("LEFT")
        elbl:SetTextColor(0.5, 0.5, 0.5)
        elbl:SetText("No catches recorded yet")

        empty:Hide()
        sec.rows[#sec.rows + 1] = empty
        return sec
    end

    for _, item in ipairs(sorted) do
        local row = CreateFrame("Frame", nil, rightList)
        row:SetHeight(STAT_H)
        row._h = STAT_H

        local iconTex = row:CreateTexture(nil, "ARTWORK")
        iconTex:SetSize(16, 16)
        iconTex:SetPoint("LEFT", row, "LEFT", 10, 0)
        if item.icon then iconTex:SetTexture(item.icon) end

        local lbl = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        lbl:SetPoint("LEFT",  row, "LEFT",   30, 0)
        lbl:SetPoint("RIGHT", row, "RIGHT", -60, 0)
        lbl:SetJustifyH("LEFT")
        lbl:SetText(item.name)

        local cnt = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        cnt:SetPoint("RIGHT", row, "RIGHT", -4, 0)
        cnt:SetJustifyH("RIGHT")
        cnt:SetText("|cFFFFD700x" .. item.total .. "|r")

        row:Hide()
        sec.rows[#sec.rows + 1] = row

        local charList = {}
        for char, n in pairs(item.byChar) do
            charList[#charList + 1] = { char = char, n = n }
        end
        table.sort(charList, function(a, b) return a.n > b.n end)

        for _, cd in ipairs(charList) do
            local sub = CreateFrame("Frame", nil, rightList)
            sub:SetHeight(SUBROW_H)
            sub._h = SUBROW_H

            local classToken = PoolepediaCharClasses and PoolepediaCharClasses[cd.char]
            local cr, cg, cb_col = 0.6, 0.6, 0.6
            if classToken and RAID_CLASS_COLORS and RAID_CLASS_COLORS[classToken] then
                local c = RAID_CLASS_COLORS[classToken]
                if c then cr, cg, cb_col = c.r, c.g, c.b end
            end

            local subLbl = sub:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            subLbl:SetPoint("LEFT",  sub, "LEFT",   34, 0)
            subLbl:SetPoint("RIGHT", sub, "RIGHT", -60, 0)
            subLbl:SetJustifyH("LEFT")
            subLbl:SetTextColor(cr, cg, cb_col)
            subLbl:SetText(cd.char)

            local subCnt = sub:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            subCnt:SetPoint("RIGHT", sub, "RIGHT", -4, 0)
            subCnt:SetJustifyH("RIGHT")
            subCnt:SetTextColor(0.6, 0.6, 0.6)
            subCnt:SetText("x" .. cd.n)

            sub:Hide()
            sec.rows[#sec.rows + 1] = sub
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
    if Poolepedia_RefreshCatalogueList then Poolepedia_RefreshCatalogueList() end
end

-- ── Fish list buttons ────────────────────────────────────────
local fishButtons = {}
local activeBtn   = nil

local function DeactivateAll()
    for _, b in ipairs(fishButtons) do
        if b._caught then
            b._bg:SetVertexColor(1, 0.82, 0, 0.18)
        else
            b._bg:SetVertexColor(1, 1, 1, 0)
        end
    end
    activeBtn = nil
end

local function RefreshFishColors()
    for _, btn in ipairs(fishButtons) do
        local entries = PoolepediaFishIndex and PoolepediaFishIndex[btn._name]
        local enabled = false
        if entries then
            for _, e in ipairs(entries) do
                local pd  = PoolepediaDB and PoolepediaDB._byName[e.poolName]
                local exp = pd and pd.expansion
                -- no expansion data, or the expansion is enabled → show
                if not exp or not PoolepediaSettings or PoolepediaSettings[exp] ~= false then
                    enabled = true
                    break
                end
            end
        else
            enabled = true  -- unknown fish, show by default
        end

        -- Re-evaluate caught status (catches may arrive after build)
        if not btn._caught and PoolepediaFishIndex and PoolepediaFishIndex[btn._name] then
            for _, e in ipairs(PoolepediaFishIndex[btn._name]) do
                local key = e.zoneID .. "/" .. e.poolName
                if PoolepediaCatches and PoolepediaCatches[key]
                    and next(PoolepediaCatches[key]) then
                    btn._caught = true
                    break
                end
            end
        end

        if btn == activeBtn then
            btn._bg:SetVertexColor(0.2, 0.55, 1, 0.30)
            btn._lbl:SetTextColor(1, 1, 1)
            if btn._icon then btn._icon:SetAlpha(1) end
        elseif not enabled then
            btn._bg:SetVertexColor(1, 1, 1, 0)
            btn._lbl:SetTextColor(0.38, 0.38, 0.38)
            if btn._icon then btn._icon:SetAlpha(0.38) end
        elseif btn._caught then
            btn._bg:SetVertexColor(1, 0.82, 0, 0.18)   -- gold background tint
            btn._lbl:SetTextColor(1, 0.85, 0.1)        -- gold text
            if btn._icon then btn._icon:SetAlpha(1) end
        else
            btn._bg:SetVertexColor(1, 1, 1, 0)
            btn._lbl:SetTextColor(1, 1, 1)
            if btn._icon then btn._icon:SetAlpha(1) end
        end
    end
end
Poolepedia_RefreshCatalogueList = RefreshFishColors

local fishListBuilt = false
local function BuildFishList()
    if fishListBuilt then return end
    if not PoolepediaFishIndex then return end

    local names = {}
    for n in pairs(PoolepediaFishIndex) do names[#names + 1] = n end
    table.sort(names)

    local y = 0
    for _, name in ipairs(names) do
        local btn = CreateFrame("Button", nil, leftList)
        btn:SetHeight(ROW_H)
        btn:SetPoint("TOPLEFT",  leftList, "TOPLEFT",   2, -y)
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
        lbl:SetPoint("LEFT",  btn, "LEFT",   24, 0)
        lbl:SetPoint("RIGHT", btn, "RIGHT",  -2, 0)
        lbl:SetJustifyH("LEFT")
        lbl:SetText(name)

        -- Check if this fish has any recorded catches (has real icon data)
        local hasCatch = tex ~= nil
        if not hasCatch and PoolepediaFishIndex and PoolepediaFishIndex[name] then
            for _, e in ipairs(PoolepediaFishIndex[name]) do
                local key = e.zoneID .. "/" .. e.poolName
                if PoolepediaCatches and PoolepediaCatches[key]
                    and next(PoolepediaCatches[key]) then
                    hasCatch = true
                    break
                end
            end
        end

        btn._name    = name
        btn._bg      = bg
        btn._lbl     = lbl
        btn._icon    = iconTex
        btn._caught  = hasCatch

        btn:SetScript("OnEnter", function(self)
            if self ~= activeBtn then
                if self._caught then
                    bg:SetVertexColor(1, 0.82, 0, 0.30)
                else
                    bg:SetVertexColor(1, 1, 1, 0.08)
                end
            end
        end)
        btn:SetScript("OnLeave", function(self)
            if self ~= activeBtn then
                if self._caught then
                    bg:SetVertexColor(1, 0.82, 0, 0.18)
                else
                    bg:SetVertexColor(1, 1, 1, 0)
                end
            end
        end)
        btn:SetScript("OnClick", function(self)
            DeactivateAll()
            activeBtn = self
            bg:SetVertexColor(0.2, 0.55, 1, 0.30)
            ShowFishZones(name)
        end)

        fishButtons[#fishButtons + 1] = btn
        y = y + ROW_H
    end
    leftList:SetHeight(math.max(y, 1))
    fishListBuilt = true
end

local iconFillFrame = CreateFrame("Frame")
iconFillFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
iconFillFrame:SetScript("OnEvent", function(_, _, _, success)
    if not success or not fishListBuilt then return end
    for _, btn in ipairs(fishButtons) do
        if not btn._icon then
            local _, _, _, _, _, _, _, _, _, tex = C_Item.GetItemInfo(btn._name)
            if tex then btn._icon:SetTexture(tex) end
        end
    end
end)

catPane:SetScript("OnShow", function()
    BuildFishList()
    RefreshFishColors()
    UpdateFilterLabel()
end)

-- ── Search OnTextChanged ─────────────────────────────────────
searchBox:HookScript("OnTextChanged", function(self)
    local query    = self:GetText():lower()
    local visibleY = 0

    for _, btn in ipairs(fishButtons) do
        local fishName = btn._name
        local match    = query == "" or fishName:lower():find(query, 1, true)
        btn:SetShown(match)

        if match then
            btn:SetPoint("TOPLEFT", leftList, "TOPLEFT", 2, -visibleY)

            if query ~= "" then
                local lower = fishName:lower()
                local s, e  = lower:find(query, 1, true)
                if s then
                    btn._lbl:SetText(
                        fishName:sub(1, s - 1)
                        .. "|cFFFFD700" .. fishName:sub(s, e) .. "|r"
                        .. fishName:sub(e + 1))
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

-- ============================================================
-- Slash Command  /pld  – toggles the catalogue panel
--                        /pld minimap – re-shows the minimap button
-- ============================================================
SLASH_POOLEPEDIA1 = "/pld"
SlashCmdList["POOLEPEDIA"] = function(msg)
    if msg and msg:lower() == "minimap" then
        if PoolepediaSettings then
            PoolepediaSettings.hideMinimapButton = false
        end
        if Poolepedia_RefreshMinimapButton then
            Poolepedia_RefreshMinimapButton()
        end
        print("|cFF00CCFFPoolepedia|r: minimap button shown.")
    else
        if frame:IsShown() then
            frame:Hide()
        else
            frame:Show()
        end
    end
end
