function moreGamesPopupCreate(self)
	local self = {}
	
	self.canvas = mgCreateCanvas(1, 1)
	mgSetAlpha(self.canvas, 0)
	mgSetOrigo(self.canvas, "center")
	mgSetPos(self.canvas, centerX, centerY)

	self.backplate = mgCreateImage("popups/more/more_bg.png")
	mgSetOrigo(self.backplate, "center")
	mgSetPos(self.backplate, 0, 0)

	local yOffsetCredits = -300;
	local yOffsetRate 	 = -150;
	local yOffsetPrivacy = 0;
	local yOffsetGames	 = 150;
	local yOffsetTwitter = 300;
	local locale = mgGet("game.locale")

	self.buttonCredits = createButton("popups/more/more_credits_btn.xml", yOffsetCredits)
	self.textButtonCredits = createText("popup_more_credits_btn", yOffsetCredits, locale)

	self.buttonRate = createButton("popups/more/more_rate_btn.xml", yOffsetRate)
	self.textButtonRate = createText("popup_more_rate_btn", yOffsetRate, locale)

	self.buttonPrivacy = createButton("popups/more/more_privacy_btn.xml", yOffsetPrivacy)
	self.textButtonPrivacy = createText("popup_more_privacy_btn", yOffsetPrivacy, locale)

	self.buttonGames = createButton("popups/more/more_games_btn.xml", yOffsetGames)
	self.textButtonGames = createText("popup_more_games_btn", yOffsetGames, locale)

	self.buttonTwitter = createButton("popups/more/more_twitter_btn.xml", yOffsetTwitter)
	self.imageTwitter = mgCreateImage("popups/more/more_twitter_logo.png")
	mgSetOrigo(self.imageTwitter, "center")
	mgSetPos(self.imageTwitter, 0, yOffsetTwitter)
	mgSetScale(self.imageTwitter, 0.5)

	return self
end

function createButton(uiPath, yOffset)
	button = mgCreateUi(uiPath)
	mgSetOrigo(button, "center")
	mgSetPos(button, 0, yOffset)
	return button
end

function createText(textId, yOffset, locale)
	newText = mgCreateUText("smash_light")
	mgSetColor(newText, 0, 0, 0)

	mgSetPos(newText, 0, 20 + yOffset)

	mgSetUText(newText, textId)
	mgSetOrigo(newText, "center")
	return newText
end



local function moreGamesPopupDraw(self)
	local alphaValue = mgGetAlpha(self.canvas)
	local is_visible = alphaValue > 0
	
	if is_visible then
		mgFullScreenColor(0, 0, 0, alphaValue * 0.5)
		mgPushCanvas(self.canvas)
		mgDraw(self.backplate)
		
		if self.text then
			mgDraw(self.text)
		end

		mgDraw(self.buttonCredits)
		mgDraw(self.textButtonCredits)

		mgDraw(self.buttonRate)
		mgDraw(self.textButtonRate)

		mgDraw(self.buttonPrivacy)
		mgDraw(self.textButtonPrivacy)

		mgDraw(self.buttonGames)
		mgDraw(self.textButtonGames)

		mgDraw(self.buttonTwitter)
		mgDraw(self.imageTwitter)

		mgPopCanvas()
	end

	return is_visible
end


local function moreGamesPopupShow(self, uiScale)
	mgSetAlpha(self.canvas, 0)
	mgSetScale(self.canvas, 1, 0.6)
	mgSetAlpha(self.canvas, 1, "easeout", 0.15)
	mgSetScale(self.canvas, 1, 1, "easeout", 0.15)

	mgSetUiModal(self.buttonCredits, true)
	mgSetUiModal(self.buttonRate, true)
	mgSetUiModal(self.buttonPrivacy, true)
	mgSetUiModal(self.buttonTwitter, true)
	mgSetUiModal(self.buttonGames, true)
end


local function moreGamesPopupHide(self)
	local instant = false
	mgSetUiModal(self.buttonCredits, false)
	mgSetUiModal(self.buttonRate, false)
	mgSetUiModal(self.buttonPrivacy, false)
	mgSetUiModal(self.buttonTwitter, false)
	mgSetUiModal(self.buttonGames, false)

	if instant then
		mgSetAlpha(self.canvas, 0)
	else
		mgSetAlpha(self.canvas, 0, "easein", 0.15)
		mgSetScale(self.canvas, 0.9, 0.7, "easein", 0.15)
	end
end


local function moreGamesPopupIsVisible(self)
	return mgGetAlpha(self.canvas) > 0
end


function createMoreGamesPopup()
		return {create = moreGamesPopupCreate, draw = moreGamesPopupDraw, show = moreGamesPopupShow, hide = moreGamesPopupHide, is_visible = moreGamesPopupIsVisible}
end

