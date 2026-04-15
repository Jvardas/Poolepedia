local addon = LibStub("AceAddon-3.0"):NewAddon("Poolepedia")
PoolepediaMinimapButton = LibStub("LibDBIcon-1.0", true)

local miniButton = LibStub("LibDataBroker-1.1"):NewDataObject("PoolepediaMinimapButton", {
	type = "data source",
	text = "Poolepedia",
	icon = "Interface\\Icons\\Trade_Fishing",
	OnClick = function(self, btn)
        if btn == "LeftButton" then
		    PoolepediaCatalogueFrame:SetShown(not PoolepediaCatalogueFrame:IsShown())
        elseif btn == "RightButton" then
            MenuUtil.CreateContextMenu(self, function(_, root)
                root:CreateTitle("Poolepedia")
                root:CreateButton("Hide minimap button", function()
                    if PoolepediaSettings then
                        PoolepediaSettings.hideMinimapButton = true
                    end
                    Poolepedia_RefreshMinimapButton()
                end)
            end)
        end
	end,

	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		tooltip:AddLine("Poolepedia", 1, 0.82, 0)
		tooltip:AddLine(" ")
		tooltip:AddLine("Left-click: open / close")
		tooltip:AddLine("Right-click: options")
		tooltip:AddLine("Drag: reposition")
		tooltip:AddLine(" ")
		tooltip:AddLine("To restore a hidden button:", 0.6, 0.6, 0.6)
		tooltip:AddLine("/pld minimap", 0.4, 0.8, 1)
	end,
})

function Poolepedia_RefreshMinimapButton()
    if not PoolepediaSettings then return end

    local shouldHide = PoolepediaSettings.hideMinimapButton or false

    -- Keep AceDB in sync so LibDBIcon restores the right state on next login
    if addon.db then
        addon.db.profile.minimap.hide = shouldHide
    end

    if PoolepediaMinimapButton then
        if shouldHide then
            PoolepediaMinimapButton:Hide("Poolepedia")
        else
            PoolepediaMinimapButton:Show("Poolepedia")
        end
    end
end

function addon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("PoolepediaMinimapButtonPOS", {
        profile = { minimap = { hide = false } },
    })

    -- Sync hide preference from PoolepediaSettings into the LibDBIcon db
    if PoolepediaSettings then
        self.db.profile.minimap.hide = PoolepediaSettings.hideMinimapButton or false
    end

    PoolepediaMinimapButton:Register("Poolepedia", miniButton, self.db.profile.minimap)
end
