local addon = LibStub("AceAddon-3.0"):NewAddon("Poolepedia")
PoolepediaMinimapButton = LibStub("LibDBIcon-1.0", true)

local miniButton = LibStub("LibDataBroker-1.1"):NewDataObject("PoolepediaMinimapButton", {
	type = "data source",
	text = "Poolepedia",
	icon = "Interface\\Icons\\Trade_Fishing",
	OnClick = function(self, btn)
        if btn == "LeftButton" then
		    PoolepediaCatalogueFrame:SetShown(not PoolepediaCatalogueFrame:IsShown())
        end
	end,

	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then
			return
		end

		tooltip:AddLine("Poolepedia\n\nClick to open/close\nDrag to reposition", nil, nil, nil, nil)
	end,
})

function Poolepedia_RefreshMinimapButton()
    if not PoolepediaSettings then return end
    
    local shouldHide = PoolepediaSettings.hideMinimapButton
    
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
		profile = {
			minimap = {
				hide = false,
			},
		},
	})

	if PoolepediaSettings and PoolepediaSettings.minimapAngle == nil then
        PoolepediaSettings.minimapAngle = 225
    end

    -- Check if button should be hidden
    if PoolepediaSettings and PoolepediaSettings.hideMinimapButton then
        self.db = LibStub("AceDB-3.0"):New("PoolepediaMinimapButtonPOS", {
			profile = {
				minimap = {
					hide = true,
				},
			},
		})
    else
        self.db = LibStub("AceDB-3.0"):New("PoolepediaMinimapButtonPOS", {
			profile = {
				minimap = {
					hide = false,
				},
			},
		})
    end

	PoolepediaMinimapButton:Register("Poolepedia", miniButton, self.db.profile.minimap)
end
