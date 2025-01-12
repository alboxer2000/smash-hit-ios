FONT_TYPE_NUMBERS = 1

local function upgradeUiCreate(centerX, centerY)
	local self = {}
	
	self.backplate = mgCreateUi("popups/upgrade_popup/upgrade.xml")
	mgSetOrigo(self.backplate, "center")
	mgSetPos(self.backplate, centerX, centerY)
	mgSetScale(self.backplate, 0, 0)
	mgSetAlpha(self.backplate, 0)

	return self
end

local function upgradeUiDraw(self)
	sx, sy = mgGetScale(self.backplate)
	
	if sx > 0 then
		mgFullScreenColor(0, 0, 0, sx * 0.4)
		mgDraw(self.backplate)
	end
end

local function upgradeUiShow(self, uiScale)
	mgSetScale(self.backplate, uiScale, uiScale, "cosine", 0.3)
	mgSetAlpha(self.backplate, 1, "easeout", 0.3)
	mgSetUiModal(self.backplate, true)
end

local function upgradeUiHide(self)
	mgSetScale(self.backplate, 0, 0, "easein", 0.7)
	mgSetAlpha(self.backplate, 0, "easein", 0.7)
	mgSetUiModal(self.backplate, false)
end

local function upgradeuiIsVisible(self)
	return mgGetAlpha(self.backplate) > 0
end


local function upgradeuiBaseCreate(centerX, centerY)
	local self = {}
	
	self.canvas = mgCreateCanvas(1, 1)
	mgSetAlpha(self.canvas, 0)
	mgSetOrigo(self.canvas, "center")
	mgSetPos(self.canvas, centerX, centerY)

	self.backplate = mgCreateImage("popups/upgrade_popup_new/upgrade_bg.png")
	mgSetOrigo(self.backplate, "center")
	mgSetPos(self.backplate, 0, 0)

	self.btn_premium = mgCreateUi("popups/upgrade_popup_new/upgrade_get_premium_btn.xml")
	mgSetOrigo(self.btn_premium, "center")

	self.btn_ad = mgCreateUi("popups/upgrade_popup_new/upgrade_watch_ad_btn.xml")
	mgSetOrigo(self.btn_ad, "center")

	self.has_ad_loaded = false

	return self
end


local function upgradeUiBaseDraw(self)
	local alphaValue = mgGetAlpha(self.canvas)
	local is_visible = alphaValue > 0
	
	if is_visible then
		mgFullScreenColor(0, 0, 0, alphaValue * 0.5)
		mgPushCanvas(self.canvas)
		mgDraw(self.backplate)
		
		if self.text then
			mgDraw(self.text)
		end

		mgDraw(self.btn_premium)
		
		if self.has_ad_loaded then
			mgDraw(self.btn_ad)
		end

		if self.custom_draw_function then
			self.custom_draw_function(self)
		end

		mgPopCanvas()
	end

	return is_visible
end

local function upgradeUiBaseShow(self, uiScale)
	mgSetAlpha(self.canvas, 0)
	mgSetScale(self.canvas, 1*uiScale, 0.6*uiScale)
	mgSetAlpha(self.canvas, 1, "easeout", 0.15)
	mgSetScale(self.canvas, 1*uiScale, 1*uiScale, "easeout", 0.15)
	mgSetUiModal(self.btn_premium, true)
end


local function upgradeUiBaseHide(self, instant)
	mgSetUiModal(self.btn_ad, false)
	mgSetUiModal(self.btn_premium, false)
	if instant then
		mgSetAlpha(self.canvas, 0)
	else
		mgSetAlpha(self.canvas, 0, "easein", 0.15)
		mgSetScale(self.canvas, 0.9, 0.7, "easein", 0.15)
	end
end


local function upgradeUiBaseIsVisible(self)
	return mgGetAlpha(self.canvas) > 0
end


local function upgradeUiV2Create(centerX, centerY)
	local self = upgradeuiBaseCreate(centerX, centerY)
	
	return self
end


local function upgradeUiV2Show(self, uiScale)
	upgradeUiBaseShow(self, uiScale)

	self.has_ad_loaded = mgIsCheckpointAdLoaded()

	if self.has_ad_loaded then
		mgSetPos(self.btn_ad, 0, -85)
		mgSetPos(self.btn_premium, 0, 85)
		mgSetUiModal(self.btn_ad, true)
	else
		mgSetPos(self.btn_premium, 0, 0)
		mgSetUiModal(self.btn_ad, false)
	end
end


local function upgradeUiV1DrawCustom(self)
	mgDraw(self.checkpointText)
	mgDraw(self.checkpointCircle)
end


local function upgradeUiV1Create(centerX, centerY)
	local self = upgradeuiBaseCreate(centerX, centerY)

	self.checkpointCircle = mgCreateImage("popups/upgrade_popup_new/checkpoint_circle.png")
	mgSetOrigo(self.checkpointCircle, "center")

	self.text = mgCreateImage("popups/upgrade_popup_new/checkpoint_text.png")
	mgSetOrigo(self.text, "center")
	mgSetScale(self.text, 1.2, 1.2)

	self.checkpointText = mgCreateText("numbers_light", FONT_TYPE_NUMBERS)
	mgSetOrigo(self.checkpointText, "center")
	local c = 70.0 / 255.0
	mgSetColor(self.checkpointText, c, c, c)
	mgSetScale(self.checkpointText, 0.65, 0.65)

	self.custom_draw_function = upgradeUiV1DrawCustom

	return self
end


local function upgradeUiV1Show(self, uiScale)
	upgradeUiBaseShow(self, uiScale)

	self.has_ad_loaded = mgIsCheckpointAdLoaded()

	local selectedLevel = mgGet("game.selectedLevel")
	if selectedLevel then
		local level = tonumber(selectedLevel)

		if level < 12 then
			mgSetText(self.checkpointText, selectedLevel)
			if level == 1 then
				self.checkpointTextXOffset = 15
			elseif level == 7 then
				self.checkpointTextXOffset = 4
			elseif level == 10 then
				self.checkpointTextXOffset = -6
			elseif level == 11 then
				self.checkpointTextXOffset = 8
			else
				self.checkpointTextXOffset = 0
			end
		else
			mgSetText(self.checkpointText, ";")
			self.checkpointTextXOffset = -19
		end
	end

	mgSetPos(self.checkpointCircle, 0, -250)
	mgSetPos(self.checkpointText, -32 + self.checkpointTextXOffset, -290)

	mgSetPos(self.btn_ad, 0, -15)
	mgSetPos(self.text, 0, -140)

	if self.has_ad_loaded then
		mgSetPos(self.btn_premium, 0, 150)
		mgSetUiModal(self.btn_ad, true)
	else
		mgSetPos(self.btn_premium, 0, 0)
		mgSetUiModal(self.btn_ad, false)
	end
end


function createUpgradePopup()
	local premium = mgGet("game.premium") == "1"
	local adsEnabledForCheckpoint = mgGetRemoteConfigBoolParameter("smashhit_ads_enabled_cp")
	local shorterAdsFlow = mgGetRemoteConfigBoolParameter("smashhit_short_cp_ads_flow")

	if not premium and adsEnabledForCheckpoint then
		if shorterAdsFlow then
			return {create = upgradeUiV1Create, draw = upgradeUiBaseDraw, show = upgradeUiV1Show, hide = upgradeUiBaseHide, is_visible = upgradeUiBaseIsVisible}
		else
			return {create = upgradeUiV2Create, draw = upgradeUiBaseDraw, show = upgradeUiV2Show, hide = upgradeUiBaseHide, is_visible = upgradeUiBaseIsVisible}
		end
	else
		return {create = upgradeUiCreate, draw = upgradeUiDraw, show = upgradeUiShow, hide = upgradeUiHide, is_visible = upgradeuiIsVisible}
	end
end


function outOfBallsPopupCreate(self)
	local self = {}
	
	self.canvas = mgCreateCanvas(1, 1)
	mgSetAlpha(self.canvas, 0)
	mgSetOrigo(self.canvas, "center")
	mgSetPos(self.canvas, centerX, centerY)

	self.backplate = mgCreateImage("popups/out_of_balls/out_of_balls_bg.png")
	mgSetOrigo(self.backplate, "center")
	mgSetPos(self.backplate, 0, 0)

	self.balls_bg = mgCreateImage("popups/out_of_balls/balls_bg.png")
	mgSetOrigo(self.balls_bg, "center")
	mgSetPos(self.balls_bg, 0, 145)

	self.btn_ad = mgCreateUi("popups/out_of_balls/out_of_balls_watch_ad_btn.xml")
	mgSetOrigo(self.btn_ad, "center")

	self.textContent = mgCreateUText("smash_light")
	mgSetColor(self.textContent, 0, 0, 0)
	mgSetUText(self.textContent, "popup_out_of_balls_title")
	mgSetOrigo(self.textContent, "center")
	mgSetPos(self.textContent, 0, -120)

	self.textButton = mgCreateUText("smash_light")
	mgSetColor(self.textButton, 0, 0, 0)
	mgSetUText(self.textButton, "popup_button_continue")
	mgSetOrigo(self.textButton, "center")
	mgSetPos(self.textButton, 25, 20)

	self.textAmount = mgCreateUText("smash")
	mgSetColor(self.textAmount, 0, 0, 0)
	local reward_amount = "" .. mgGet("game.out_of_balls_ad_reward")
	mgSetUText(self.textAmount, "popup_out_of_balls_amount", "amount", reward_amount)
	mgSetOrigo(self.textAmount, "center")
	mgSetPos(self.textAmount, 50, 162)

	return self
end


local function outOfBallsPopupDraw(self)
	local alphaValue = mgGetAlpha(self.canvas)
	local is_visible = alphaValue > 0
	
	if is_visible then
		mgFullScreenColor(0, 0, 0, alphaValue * 0.5)
		mgPushCanvas(self.canvas)
		mgDraw(self.backplate)
		
		if self.text then
			mgDraw(self.text)
		end

		mgDraw(self.btn_ad)

		mgDraw(self.balls_bg)

		mgDraw(self.textContent)

		mgDraw(self.textAmount)

		mgDraw(self.textButton)

		mgPopCanvas()
	end

	return is_visible
end


local function outOfBallsPopupShow(self, uiScale)
	mgCommand("game.setSourceForAd level")
	mgCommand("game.ad_popup_shown out_of_balls")

	mgSetAlpha(self.canvas, 0)
	mgSetScale(self.canvas, 1*uiScale, 0.6*uiScale)
	mgSetAlpha(self.canvas, 1, "easeout", 0.15)
	mgSetScale(self.canvas, 1*uiScale, 1*uiScale, "easeout", 0.15)
	mgSetUiModal(self.btn_ad, true)
end


local function outOfBallsPopupHide(self)
	local instant = false
	mgSetUiModal(self.btn_ad, false)
	if instant then
		mgSetAlpha(self.canvas, 0)
	else
		mgSetAlpha(self.canvas, 0, "easein", 0.15)
		mgSetScale(self.canvas, 0.9, 0.7, "easein", 0.15)
	end
end


local function outOfBallsPopupIsVisible(self)
	return mgGetAlpha(self.canvas) > 0
end


function createOutOfBallsPopup()
		return {create = outOfBallsPopupCreate, draw = outOfBallsPopupDraw, show = outOfBallsPopupShow, hide = outOfBallsPopupHide, is_visible = outOfBallsPopupIsVisible}
end

