MODE_TRAINING = 0
MODE_CLASSIC = 1
MODE_EXPERT = 2
MODE_ZEN = 3
MODE_VERSUS = 4
MODE_COOP = 5
MODE_COUNT = 6

FONT_TYPE_DEFAULT = 0;
FONT_TYPE_NUMBERS = 1;
FONT_TYPE_EXTENDED = 2;	-- CoffeeStain 2024, full ASCII support

function startsWith(str,start)
   return string.sub(str,1,string.len(start))==start
end

function getFirst(str)
	i = string.find(str, " ")
	if i then
		return string.sub(str, 1, i-1)
	end
	return str
end

function getSecond(str)
	i = string.find(str, " ")
	if i > 0 then
		i = i + 1
		return string.sub(str, i, string.len(str))
	end
	return ""
end

local function initDisplay()
	top = tonumber(mgGet("display.visibleTop"))
	left = tonumber(mgGet("display.visibleLeft"))
	right = tonumber(mgGet("display.visibleRight"))
	bottom = tonumber(mgGet("display.visibleBottom"))
	centerX = (left+right)/2
	centerY = (top+bottom)/2	
	
	local aspectMultiplier = math.min(mgGetAspectMultiplier(), 1.8328)
	hudHalfAspectMultiplier = (aspectMultiplier - 1.0) / 2.0 + 1.0
	streakHudOffset = 100 * (hudHalfAspectMultiplier - 1.0)
	PU_OFFSET_X = 160
	PU_OFFSET_Y = 120
end

function initGlobals()
	frameCounter = 0
	initDisplay()
end



---------------------------------------------------------------------------------
---------------------------------------------------------------------------------


function init()
	initGlobals()

	uiScale = 1.6 --tonumber(mgGet("game.uiscale"))
	PU_SCALE = uiScale
	
	pauseUi = mgCreateUi("pause.xml")
	mgSetOrigo(pauseUi, "center")
	mgSetScale(pauseUi, 1 * hudHalfAspectMultiplier, 1 * hudHalfAspectMultiplier)
	mgSetPos(pauseUi, right - PU_OFFSET_X * hudHalfAspectMultiplier, top + PU_OFFSET_Y * hudHalfAspectMultiplier)

	pauseRotUi = mgCreateUi("pause_rot.xml")
	mgSetOrigo(pauseRotUi, "center")
	mgSetScale(pauseRotUi, 1, 1)
	mgSetPos(pauseRotUi, centerX, top+100)
	
	backUi = mgCreateUi("back.xml")
	mgSetOrigo(backUi, "topleft")
	mgSetPos(backUi, left+46, top+46)

	licensesUi = mgCreateUi("licenses.xml")
	mgSetOrigo(licensesUi, "bottomleft")
	mgSetPos(licensesUi, left+46, bottom-46)
	
	pauseMenuUi = mgCreateUi("pausemenu.xml")
	mgSetOrigo(pauseMenuUi, "center")
	mgSetPos(pauseMenuUi, centerX, centerY)
	mgSetScale(pauseMenuUi, 0, 0)
	mgSetAlpha(pauseMenuUi, 0)

	scoreText = mgCreateText("numbers_bold_shadow", FONT_TYPE_NUMBERS)
	mgSetScale(scoreText, 1 * hudHalfAspectMultiplier, 1 * hudHalfAspectMultiplier)
	mgSetPos(scoreText, centerX, top + 120 + streakHudOffset)

	distanceText = mgCreateText("numbers", FONT_TYPE_NUMBERS)
	mgSetScale(distanceText, 1, 1)
	mgSetPos(distanceText, left+50, bottom-160)
	
	crosshair = mgCreateImage("crosshair.png")
	mgSetOrigo(crosshair, "center")
	mgSetPos(crosshair, 512, 384)
	
	notifyText = mgCreateText("smashhit", FONT_TYPE_DEFAULT)
	mgSetPos(notifyText, 512, top-50)

	clearedText = mgCreateText("smashhit", FONT_TYPE_DEFAULT)
	mgSetAlpha(clearedText, 0)

	checkpoint = mgCreateImage("checkpoint.png")
	mgSetOrigo(checkpoint, "center")
	mgSetPos(checkpoint, centerX, centerY)
	mgSetAlpha(checkpoint, 0)

	checkpointSaved = mgCreateImage("checkpoint_saved.png")
	mgSetOrigo(checkpointSaved, "center")
	mgSetPos(checkpointSaved, centerX, centerY+150)
	mgSetAlpha(checkpointSaved, 0)

	checkpointText = mgCreateText("numbers_light", FONT_TYPE_NUMBERS)
	mgSetColor(checkpointText, 0, 0, 0)
	mgSetPos(checkpointText, centerX+348, centerY)
	mgSetAlpha(checkpointText, 0)

	inventoryText = mgCreateText("numbers", FONT_TYPE_NUMBERS)
	mgSetScale(inventoryText, 0.55, 0.55)
	
	puName = {}
	puName[0] = "ballfrenzy"
	puName[1] = "nitroballs"
	puName[2] = "slowmotion"

	puVisible = {}
	puImg = {}
	for i=0, #puName do
		local name = puName[i]
		puImg[name] = mgCreateImage("streak.png", (i+2)*210, 0, (i+3)*210, 210)
		mgSetOrigo(puImg[name], "center")
		puVisible[name] = false
	end
	
	resumeUi = mgCreateUi("resume.xml")
	mgSetOrigo(resumeUi, "center")
	mgSetPos(resumeUi, centerX, centerY)
	mgSetScale(resumeUi, 0, 0)	
	mgSetAlpha(resumeUi, 0)	

	streakBalls = mgCreateImage("streak_balls.png")
	streakBg = mgCreateImage("streak.png", 210, 0, 420, 210)
	streakPie = mgCreateImage("streak.png", 0, 0, 210, 210)
	mgSetOrigo(streakBg, "center")
	mgSetScale(streakBg, hudHalfAspectMultiplier, hudHalfAspectMultiplier)
	mgSetOrigo(streakPie, "center")
	mgSetScale(streakPie, hudHalfAspectMultiplier, hudHalfAspectMultiplier)
	mgSetPos(streakBg, centerX - 350 * hudHalfAspectMultiplier, top + 15 + streakHudOffset)
	mgSetPos(streakPie, centerX - 350 * hudHalfAspectMultiplier, top + 15 + streakHudOffset)

	pickupText = mgCreateText("numbers_bold", FONT_TYPE_NUMBERS)	
	mgSetScale(pickupText, 0, 0)

	progressImg = mgCreateImage("progress.png")
	mgSetPos(progressImg, left, top);
	
	upgradePopup = createUpgradePopup()
	upgradePopupObj = upgradePopup.create(centerX, centerY)
	
	outOfBallsPopup = createOutOfBallsPopup()
	outOfBallsPopupObj = outOfBallsPopup.create(centerX, centerY)

	saleHud = mgCreateImage("hud/sale/smashhit_sale_hud.png")
	mgSetPos(saleHud, centerX+410, centerY+50)
	mgSetOrigo(saleHud, "center")

	clearedFrame = 0
	clearedBonus = 0
	clearedBonusDone = false
	clearedMultiplier = 1
	
	countdown = mgCreateText("numbers_bold_shadow", FONT_TYPE_NUMBERS)
	mgSetAlpha(countdown, 0)
	mgSetPos(countdown, centerX, centerY-200)
	
	border = mgCreateImage("border.png")
	mgSetScale(border, 4*((right-left)/2048), 4*((bottom-top)/1536))
	mgSetPos(border, 0, top)

	if mgGet("game.level") == "level:moregames" then
		creditsLogo = mgCreateImage("granny_logo.png")
		mgSetOrigo(creditsLogo, "center")
		mgSetPos(creditsLogo, centerX, top-300)
		mgRunDelayed('mgSetPos(creditsLogo, centerX, top+300, "easeout", 1)', 4)
		mgRunDelayed('mgSetPos(creditsLogo, centerX, top-300, "easein", 1)', 14)

		mgRunDelayed('creditsLogo=mgCreateImage("sprinkle_logo.png") mgSetOrigo(creditsLogo, "center") mgSetPos(creditsLogo, centerX, top-300)', 16)
		mgRunDelayed('mgSetPos(creditsLogo, centerX, top+300, "easeout", 1)', 16)
		mgRunDelayed('mgSetPos(creditsLogo, centerX, top-300, "easein", 1)', 28)


		-- Simon's note 24-06-25: Commented out the app store button for the games since they've been removed from the store, 
		-- and so the links are dead. If we ever decide to update them again we can comment this back in.

		--appStore = mgCreateUi("appstore_granny.xml")
		--mgSetOrigo(appStore, "center")
		--mgSetPos(appStore, centerX, bottom+200)
		--mgRunDelayed('mgSetPos(appStore, centerX, bottom-200, "easeout", 1)', 4)
		--mgRunDelayed('mgSetPos(appStore, centerX, bottom+200, "easeout", 1)', 14)

		--mgRunDelayed('appStore = mgCreateUi("appstore_sprinkle.xml") mgSetOrigo(appStore, "center") mgSetPos(appStore, centerX, bottom+200)', 16)
		--mgRunDelayed('mgSetPos(appStore, centerX, bottom-200, "easeout", 1)', 16)
		--mgRunDelayed('mgSetPos(appStore, centerX, bottom+200, "easeout", 1)', 28)
	end

	lastBallCount = 0
	lastMultiplier = 0
	lastBallCountFeedback = -1
	
	puStack = {}
	for i=0, 3 do
		puStack[i] = mgCreateImage("powerup_bg.png", 0, 0, 210, 210)
		mgSetOrigo(puStack[i], "center")
		mgSetAlpha(puStack[i], 0)
		mgSetPos(puStack[i], left+100+PU_OFFSET_X-i*40, bottom-100-PU_OFFSET_Y)
	end
	
	puCorner = mgCreateImage("pucorner.png")
	mgSetOrigo(puCorner, "bottomleft")
	mgSetPos(puCorner, left, bottom)
	
	pu = mgCreateUi("pu.xml")
	mgSetOrigo(pu, "center")
	mgSetPos(pu, left+100+PU_OFFSET_X, bottom-100-PU_OFFSET_Y)
	mgSetAlpha(pu, 0)
	
	puActivateSound = mgCreateSound("powerup.ogg")
	puSlomoSound = mgCreateSound("snd/slomo.ogg")

	hintFrenzyTouchFrames = 0
	
	hintMiss = mgCreateText("smashhit", FONT_TYPE_DEFAULT)
	mgSetText(hintMiss, "miss ")
	mgSetOrigo(hintMiss, "center")
	mgSetScale(hintMiss, 0,0)
	
	hintFrenzyScore = mgCreateImage("hint_swipe_score.png")
	mgSetOrigo(hintFrenzyScore, "center")

	hintTimer = 0
	hintImg = mgCreateImage("hints.png", 0, 0, 4096, 200)
	mgSetOrigo(hintImg, "bottomcenter")
	mgSetScale(hintImg, 1.3333)
	mgSetPos(hintImg, centerX, bottom)
	mgSetAlpha(hintImg, 0)
	
	zen = (mgGet("player.mode") == "3")
	expert = (mgGet("player.mode") == "2")
	
	scoreCanvas = mgCreateCanvas(2058,1536)
	
	winner = mgCreateUi("winner.xml")
	mgSetOrigo(winner, "center")
	mgSetAlpha(winner, 0)
end

function pushPowerup()
	for i=0, #puStack do
		local visible = true
		local typ = mgGet("player.powerup"..i)
		if typ == "ballfrenzy" then
			mgSetCrop(puStack[i], 0, 0, 210, 210)
		elseif typ == "nitroballs" then
			mgSetCrop(puStack[i], 210, 0, 420, 210)
		elseif typ == "slowmotion" then
			mgSetCrop(puStack[i], 420, 0, 630, 210)
		else
			visible = false
		end
		if visible then
			local j = i-1

			if i==0 then
				mgSetPos(puStack[i], left+200+PU_OFFSET_X, bottom-200-PU_OFFSET_Y)
				mgSetPos(puStack[i], left+100+PU_OFFSET_X, bottom-100-PU_OFFSET_Y, "easeout", 0.4)
				mgSetScale(puStack[i], 2*PU_SCALE, 2*PU_SCALE)
				mgSetScale(puStack[i], 1*PU_SCALE, 1*PU_SCALE, "easeout", 0.4)
				mgSetAlpha(puStack[i], 0)
				mgSetAlpha(puStack[i], 1, "easeout", 0.4)
			elseif i==1 then
					mgSetPos(puStack[i], left+100+PU_OFFSET_X, bottom-100-PU_OFFSET_Y)
					mgSetPos(puStack[i], left+100+PU_OFFSET_X, bottom-200-(60*PU_SCALE)-PU_OFFSET_Y, "easeout", 0.4)
					mgSetScale(puStack[i], 1*PU_SCALE, 1*PU_SCALE)
					mgSetScale(puStack[i], 0.5*PU_SCALE, 0.5*PU_SCALE, "easeout", 0.4)
					mgSetAlpha(puStack[i], 1)
					mgSetAlpha(puStack[i], 0.3, "easeout", 0.4)
			else
				mgSetPos(puStack[i], left+100+PU_OFFSET_X, bottom-150-90*j*PU_SCALE-PU_OFFSET_Y)
				mgSetPos(puStack[i], left+100+PU_OFFSET_X, bottom-150-90*i*PU_SCALE-PU_OFFSET_Y, "easeout", 0.4)
				mgSetScale(puStack[i], 0.5*PU_SCALE, 0.5*PU_SCALE)
				mgSetAlpha(puStack[i], 0.3)
			end
		else
			mgSetAlpha(puStack[i], 0)
		end
	end
	mgSetAlpha(pu, 1)
end


function popPowerup()
	mgPlaySound(puActivateSound)
	local count = 0
	for i=0, #puStack do
		local visible = true
		local typ = mgGet("player.powerup"..i)
		if typ == "ballfrenzy" then
			mgSetCrop(puStack[i], 0, 0, 210, 210)
		elseif typ == "nitroballs" then
			mgSetCrop(puStack[i], 210, 0, 420, 210)
		elseif typ == "slowmotion" then
			mgSetCrop(puStack[i], 420, 0, 630, 210)
		else
			visible = false
		end
		if visible then
			local j = i-1
			mgSetPos(puStack[i], left+100+PU_OFFSET_X, bottom-150-90*i*PU_SCALE-PU_OFFSET_Y)
			mgSetPos(puStack[i], left+100+PU_OFFSET_X, bottom-150-90*j*PU_SCALE-PU_OFFSET_Y, "easeout", 0.4)
			if i==0 then
				mgSetAlpha(puStack[i], 1)
				mgSetAlpha(puStack[i], 0, "easeout", 0.4)
				mgSetPos(puStack[i], left+100+PU_OFFSET_X, bottom-100-PU_OFFSET_Y)
				mgSetPos(puStack[i], left+200+PU_OFFSET_X, bottom-200-PU_OFFSET_Y, "easeout", 0.4)
				mgSetScale(puStack[i], 1*PU_SCALE, 1*PU_SCALE)
				mgSetScale(puStack[i], 2*PU_SCALE, 2*PU_SCALE, "easeout", 0.4)
			elseif i==1 then
				mgSetPos(puStack[i], left+100+PU_OFFSET_X, bottom-100-PU_OFFSET_Y, "easeout", 0.4)
				mgSetScale(puStack[i], 0.5*PU_SCALE, 0.5*PU_SCALE)
				mgSetScale(puStack[i], 1*PU_SCALE, 1*PU_SCALE, "easeout", 0.4)
				mgSetAlpha(puStack[i], 0.3)
				mgSetAlpha(puStack[i], 1, "easeout", 0.4)
			else
				mgSetAlpha(puStack[i], 0.3, "easeout", 0.4)
				mgSetScale(puStack[i], 0.5*PU_SCALE, 0.5*PU_SCALE)
			end
			count = count + 1
		else
			mgSetAlpha(puStack[i], 0)
		end
	end
	if count == 1 then
		mgSetAlpha(pu, 0)
	end
	if hintArrow then
		mgSetAlpha(hintArrow, 0, "linear", 0.4)
	end
end


function frame()
	local credits = (mgGet("level.credits") == "1")
	frameCounter = frameCounter + 1

	local distance = tonumber(mgGet("level.distance"))

	mode = tonumber(mgGet("player.mode"))
	streak = tonumber(mgGet("level.streak"))
	multiplier = math.floor(streak/10)+1
	if multiplier > 5 then multiplier = 5 end
	
	if multiplier > lastMultiplier and multiplier > 0 and frameCounter > 10 and distance < 3000 then
		hintStreak = true
	end
	lastMultiplier = multiplier
	
	ballCount = tonumber(mgGet("level.ballcount"))
	if not zen and mode ~= MODE_COOP and mode ~= MODE_VERSUS then
		if distance > 11980 and distance < 12000 and not hintDone then
			hintDone = mgCreateImage("endless_mode.png")
			mgSetOrigo(hintDone, "center")
			mgSetPos(hintDone, centerX, centerY)
			mgSetAlpha(hintDone, 0)
			mgSetAlpha(hintDone, 1, "linear", 0.5)
			mgRunDelayed('mgSetAlpha(hintDone, 0, "linear", 0.5)', 3.0)
		end
	end
	
	if not credits and not zen and not expert then
		if distance > 5 and distance < 30 and not hint1shown then
			hint1shown = true
			hintTimer = 180
			mgSetCrop(hintImg, 0, 0, 4096, 200)
			mgSetAlpha(hintImg, 1, "linear", 0.2)
		elseif distance > 70 and distance < 100 and not hint2shown then
			hint2shown = true
			hintTimer = 240
			mgSetCrop(hintImg, 0, 200, 4096, 400)
			mgSetAlpha(hintImg, 1, "linear", 0.2)
		elseif distance < 1000 and hintStreak and not hint3shown then
			hint3shown = true
			hintTimer = 300
			mgSetCrop(hintImg, 0, 400, 4096, 600)
			mgSetAlpha(hintImg, 1, "linear", 0.2)
		elseif distance < 1000 and tonumber(mgGet("level.pain")) > 0 and not hint4shown then
			hint4shown = true
			hintTimer = 180
			mgSetCrop(hintImg, 0, 600, 4096, 800)
			mgSetAlpha(hintImg, 1, "linear", 0.2)
		end
		if frameCounter > 60 and ballCount == 0 and not hint5shown then
			hint5shown = true
			hintTimer = 150
			mgSetCrop(hintImg, 0, 800, 4096, 1000)
			mgSetAlpha(hintImg, 1, "linear", 0.2)
		end
		if hintTimer > 0 then
			hintTimer = hintTimer - 1
			if hintTimer == 0 then
				mgSetAlpha(hintImg, 0, "linear", 0.2)
			end
		end 
	end
end


function drawScore(ballCount, streak)
	if not gShowUI then
		return
	end

	if mgGetPowerupFraction("ballfrenzy") > 0 then
		mgSetPos(hintFrenzyScore, 0, streakHudOffset)
		mgSetScale(hintFrenzyScore, hudHalfAspectMultiplier, hudHalfAspectMultiplier)
		mgDraw(hintFrenzyScore)
	else
		mgSetPos(scoreText, 110, -60)
		mgSetText(scoreText, ballCount) 
		mgDraw(scoreText)
	end

	local streakFrac = ((streak%10))/10
	mgSetPos(streakBg, 0, streakHudOffset)
	mgDraw(streakBg)

	if streak < 40 then
		mgSetPos(streakPie, 0, streakHudOffset) 
		mgDrawPie(streakPie, streakFrac)
	end

	local multiplier = math.floor(streak/10)+1
	if multiplier > 5 then multiplier = 5 end

	mgSetCrop(streakBalls, 210*(multiplier-1), 0, 210*multiplier, 210)
	mgSetOrigo(streakBalls, "center")
	mgSetScale(streakBalls, hudHalfAspectMultiplier, hudHalfAspectMultiplier)
	mgSetPos(streakBalls, 0, streakHudOffset)
	mgDraw(streakBalls)
end


function conditionalDraw(element)
	if gShowUI then
		mgDraw(element)
	end
end

function conditionalDrawPie(element, frac)
	if gShowUI then
		mgDrawPie(element)
	end
end


function draw()
--if asdasdasd==nil then return end
	gShowUI = (mgGet("game.showui") == "1")
	initDisplay()

	local credits = (mgGet("level.credits") == "1")

	local t = mgGet("game.menutransition")
	t = 1.0 - (t*2)
	if t < 0 then t = 0 end
	if t > 1 then t = 1 end

	xColor = { mgGetMultiplierColor(multiplier) }

	--Distance progress bar
	local progress = tonumber(mgGet("level.progress"))
	mgSetScale(progressImg, progress/128*2048, 0.5)
	conditionalDraw(progressImg)

	if credits then
		mgSetAlpha(backUi, t)
		mgDraw(backUi)

		local moregames = (mgGet("level.moregames") == "1")
		if not moregames then
			mgSetAlpha(licensesUi, t)
			mgDraw(licensesUi)
		end
	else
		if mode == MODE_VERSUS or mode == MODE_COOP then
			mgSetAlpha(pauseRotUi, t)
			conditionalDraw(pauseRotUi)
		else
			mgSetAlpha(pauseUi, t)
			conditionalDraw(pauseUi)
		end
	end

	local totalCount = 0

	mgSetAlpha(scoreText, t)
	mgSetAlpha(streakBg, t)
	mgSetAlpha(streakPie, t)
	mgSetAlpha(streakBalls, t)

	local scoreX = centerX;
	local multX = scoreX-90;
	local multY = top+110
	mgSetPos(scoreText, scoreX, top + 40 + streakHudOffset, "linear")

	if not credits then
		if not zen then
			if mode == MODE_VERSUS then
				mgSetPos(scoreCanvas, centerX-100, centerY)
				mgSetRot(scoreCanvas, -math.pi/2)
				mgPushCanvas(scoreCanvas)
				drawScore(tonumber(mgGet("level.ballcount0")), tonumber(mgGet("level.streak0")))
				mgPopCanvas()
				
				mgSetPos(scoreCanvas, centerX+100, centerY)
				mgSetRot(scoreCanvas, math.pi/2)
				mgPushCanvas(scoreCanvas)
				drawScore(tonumber(mgGet("level.ballcount1")), tonumber(mgGet("level.streak1")))
				mgPopCanvas()
			elseif mode == MODE_COOP then
				mgSetPos(scoreCanvas, centerX, centerY)
				mgSetRot(scoreCanvas, -math.pi/2)
				mgPushCanvas(scoreCanvas)
				
				mgSetPos(scoreText, 15, -140)
				mgSetRot(scoreText, math.pi)
				mgSetText(scoreText, ballCount) 
				mgSetOrigo(scoreText, "center")
				mgSetScale(scoreText, 0.75)
				conditionalDraw(scoreText)

				mgSetPos(scoreText, -15, 140)
				mgSetRot(scoreText, 0)
				conditionalDraw(scoreText)

				local streak0 = tonumber(mgGet("level.streak0"))
				local streak1 = tonumber(mgGet("level.streak1"))
				local streakFrac0 = streak0/10.0
				local streakFrac1 = streak1/10.0
				mgSetPos(streakBg, 0, 0)
				conditionalDraw(streakBg)

				if streak < 40 then
					mgSetPos(streakPie, 0, 0)
					mgSetRot(streakPie, math.pi*1.5)
					conditionalDrawPie(streakPie, streakFrac0)
					mgSetRot(streakPie, math.pi*0.5)
					conditionalDrawPie(streakPie, streakFrac1)
				end

				local multiplier = math.floor(streak/10)+1
				if multiplier > 5 then multiplier = 5 end

				mgSetCrop(streakBalls, 210*(multiplier-1), 0, 210*multiplier, 210)
				mgSetOrigo(streakBalls, "center")
				mgSetPos(streakBalls, 0, 0)
				conditionalDraw(streakBalls)
				
				mgPopCanvas()
				
				--mgSetPos(scoreCanvas, centerX+100, centerY)
			--	mgSetRot(scoreCanvas, math.pi/2)
			--	mgPushCanvas(scoreCanvas)
			--	drawScore(ballCount, streak)
			--	mgPopCanvas()
			else
				mgSetPos(scoreCanvas, multX, multY)
				mgPushCanvas(scoreCanvas)
				drawScore(ballCount, streak)
				mgPopCanvas()
			end
		end
	else
		if creditsLogo then
			mgSetAlpha(creditsLogo, t)
			mgDraw(creditsLogo)
		end
		if appStore then
			mgSetAlpha(appStore, t)
			mgDraw(appStore)
		end
		if tonumber(mgGet("level.distance")) > 100 then
			if not bowlingScoreSnd then
				bowlingScoreSnd = mgCreateSound("snd/multiplier_increase.ogg")
				bowlingScore = 0
			end
			
			local egg = tonumber(mgGet("level.egg"))
			if egg > bowlingScore then
				bowlingScore = egg
				mgPlaySound(bowlingScoreSnd)
			end
			if bowlingScore > 0 then
				mgSetText(scoreText, bowlingScore)
				conditionalDraw(scoreText)
			end
		end
	end
	
	local sx, sy = mgGetScale(pauseMenuUi)
	if sx > 0 then
		mgFullScreenColor(0,0,0,sx*0.4)
		mgDraw(pauseMenuUi)
	end

	local sx, sy = mgGetScale(resumeUi)
	if sx > 0 then
		mgFullScreenColor(0,0,0,sx*0.4)
		mgDraw(resumeUi)
	end
	
	
	local showBorder = false
	local borderColor = {1,1,1,1}
	for i=0, #puName do
		local name = puName[i]
		local frac = mgGetPowerupFraction(name)
		if puVisible[name] and frac <= 0 then
			mgSetScale(puImg[name], 0, 0)
			puVisible[name] = false
		end
		if not puVisible[name] and frac > 0 then
			mgSetAlpha(puImg[name], 0)
			mgSetAlpha(puImg[name], 1, "linear", 0.5)
			mgSetScale(puImg[name], 4, 4)
			mgSetScale(puImg[name], 1, 1, "easeout", 0.5)
			puVisible[name] = true
		end
		if frac > 0 then
			mgSetPos(puImg[name], multX, multY)
			conditionalDrawPie(puImg[name], frac)
			if name == "ballfrenzy" then borderColor = {0,1,0,1} end
			if name == "slowmotion" then borderColor = {1,0,1,1} end
			if name == "nitroballs" then borderColor = {1,1,0,1} end
			if frac < 0.25 then
				local t = frac/0.25
				local a = math.cos(t*math.pi*5+math.pi) * 0.4 + 0.6
				borderColor[4] = a
			end
			showBorder = true
		end
	end
	
	ballCount = tonumber(mgGet("level.ballcount"))
	local ballCountFeedback = tonumber(mgGet("game.new_ballcount_feedback"))

	if ballCountFeedback >= 0 then
		if ballCountFeedback ~= lastBallCountFeedback then
			local newBallcountFeedbackDelay = tonumber(mgGet("game.new_ballcount_feedback_delay"))
			mgSetText(countdown, ballCountFeedback)
			mgSetOrigo(countdown, "pixel", 50, 70)
			if ballCount == 0 then
				mgSetOrigo(countdown, "pixel", 30, 70)
			end
			mgSetScale(countdown, 1, 1)
			mgSetScale(countdown, 5, 5, "easein", newBallcountFeedbackDelay)
			mgSetAlpha(countdown, 1)
			mgSetAlpha(countdown, 0, "easein", newBallcountFeedbackDelay + 0.1)
			lastBallCountFeedback = ballCountFeedback
		end
	else
		if ballCount < lastBallCount and ballCount < 10 and ballCount > 0 then
			mgSetText(countdown, ballCount)
			mgSetOrigo(countdown, "pixel", 50, 70)
			if ballCount == 1 then mgSetOrigo(countdown, "pixel", 30, 70) end
			mgSetScale(countdown, 5, 5)
			mgSetScale(countdown, 1, 1, "easein", 0.5)
			mgSetAlpha(countdown, 1)
			mgSetAlpha(countdown, 0, "easein", 0.6)
		end
	end

	lastBallCount = ballCount
	
	mgSetAlpha(puCorner, 2*math.max(mgGetAlpha(puStack[0]), mgGetAlpha(puStack[1])))
	conditionalDraw(puCorner)
	for i=#puStack,0,-1 do
		conditionalDraw(puStack[i])
	end
	conditionalDraw(pu)

	conditionalDraw(checkpoint)
	conditionalDraw(checkpointText)
	conditionalDraw(checkpointSaved)
	conditionalDraw(countdown)

	if mode ~= MODE_ZEN and mode ~= MODE_COOP and mode ~= MODE_VERSUS then
		--conditionalDraw(pickupText)

		if not zen and not expert then
			conditionalDraw(hintImg)
		
			if hint then
				local a = mgGetAlpha(hint)
				if a > 0 then
					conditionalDraw(hint)
					if a == 1 and mgIsTouched(centerX, centerY, 200000) then
						mgSetAlpha(hint, 0, "linear", 0.4)
						mgSet("game.paused", 0)
					end
				end
			end

			if hintArrow then
				local a = mgGetAlpha(hintArrow)
				if a > 0 then
					local x,y = mgGetPos(pu)
					local offset = math.sin(mgScriptTime()*7)*50 + 200*PU_SCALE
					local PU_X_TWEAK = 0
					mgSetPos(hintArrow, x+PU_X_TWEAK, y-offset)
					mgSetScale(hintArrow, PU_SCALE, PU_SCALE)
					conditionalDraw(hintArrow)
				end
			end
			if hintFrenzy then
				local a = mgGetAlpha(hintFrenzy)
				if a > 0 then
					conditionalDraw(hintFrenzy)
					local x,y = mgGetPos(hintFrenzyHandGuide)
					mgSetPos(hintFrenzyHand, x, y+70*math.sin(x*0.007+4.5) - 10)
					conditionalDraw(hintFrenzyHand)
					for i=1, 5 do
						local px = centerX-400+i*130
						if x > px+100 then
							mgSetPos(hintFrenzyBall, px, y-110 + 70*math.sin(px*0.007+5.5) - 10)
							conditionalDraw(hintFrenzyBall)
						end
					end
					if a == 1 and mgIsTouched(centerX, centerY, 200000) then
						mgSet("game.paused", 0)
						mgSetAlpha(hintFrenzy, 0, "linear", 0.4)
						mgSetAlpha(hintFrenzyHand, 0, "linear", 0.4)
						mgSetAlpha(hintFrenzyBall, 0, "linear", 0.4)
					end
				end
			end
		end

	end

	upgradePopup.draw(upgradePopupObj)
	outOfBallsPopup.draw(outOfBallsPopupObj)
	
	local pain = tonumber(mgGet("level.pain"))
	if pain > 0 then
		showBorder = true
		borderColor = {1,0,0,pain}
	end
	
	if hintDone then
		conditionalDraw(hintDone)
	end
	
	if mode == MODE_VERSUS and mgGetAlpha(winner) > 0 then
		mgDraw(winner)
	end
	
	if showBorder then
		if mode == MODE_VERSUS then
			mgFullScreenColor(borderColor[1], borderColor[2], borderColor[3], borderColor[4], true)
		else
			mgSetColor(border, borderColor[1], borderColor[2], borderColor[3])
			mgSetAlpha(border, borderColor[4])
			mgDrawBorder(border)
		end
	end
end

function hideCheckpoint()
	mgSetAlpha(checkpoint, 0.0, "linear", 0.5)
	mgSetAlpha(checkpointText, 0.0, "linear", 0.5)
	mgSetAlpha(checkpointSaved, 0.0, "linear", 0.5)
end

function showSaved()
	mgSetScale(checkpointSaved, 2, 2)
	mgSetScale(checkpointSaved, 1, 1, "easeout", 0.5)
	mgSetAlpha(checkpointSaved, 1, "linear", 0.5)
end

function handleCommand(cmd)
	if getFirst(cmd) == "checkpoint" then
		local cp = tonumber(getSecond(cmd))
		local balls = tonumber(mgGet("level.ballcount"))
		local best = mgGetHighScore(cp)

		if balls == best then
			mgRunDelayed('showSaved()', 1.0)
		end

		if cp < 12 then
			mgSetText(checkpointText, cp)
		else
			mgSetText(checkpointText, ";")
		end
		mgSetOrigo(checkpointText, "center")
		mgSetAlpha(checkpoint, 1, "linear", 0.5)
		mgSetAlpha(checkpointText, 1, "linear", 0.5)
		mgRunDelayed('hideCheckpoint()', 3.0)
	end

	if cmd == "showpausemenu" then
		mgCommand("game.popup_shown pause")
		mgSetScale(pauseMenuUi, uiScale, uiScale, "easeout", 0.15)
		mgSetAlpha(pauseMenuUi, 1, "easeout", 0.15)
		mgSet("game.paused", "1")
		mgSetUiModal(pauseMenuUi, true)
	end

	if cmd == "hidepausemenu" then
		mgSetScale(pauseMenuUi, 0, 0, "easein", 0.15)
		mgSetAlpha(pauseMenuUi, 0, "easein", 0.15)
		mgSet("game.paused", "0")
		mgSetUiModal(pauseMenuUi, false)
	end

	if getFirst(cmd) == "notify" then
		notify(getSecond(cmd))
	end

	if cmd == "showwinner" then
		mgSetUiModal(winner, true)
		mgSetAlpha(winner, 1, "linear", 0.3)
		mgSetScale(winner, 2, 2)
		mgSetScale(winner, 1, 1, "easeout", 0.3)
		if tonumber(mgGet("level.ballcount0")) < tonumber(mgGet("level.ballcount1")) then
			mgSetRot(winner, math.pi/2)
			mgSetPos(winner, centerX+500, centerY)
		elseif tonumber(mgGet("level.ballcount0")) > tonumber(mgGet("level.ballcount1")) then
			mgSetRot(winner, -math.pi/2)
			mgSetPos(winner, centerX-500, centerY)
		else
			mgSetAlpha(winner, 0.001)
			mgSetRot(winner, 0)
			mgSetPos(winner, centerX, centerY)
		end
	end
	
	if cmd == "hidewinner" then
		mgSetUiModal(winner, false)
		mgSetAlpha(winner, 0.5, "linear", 0.3)
		mgSetScale(winner, 0, "easeout", 0.3)
	end

	if cmd == "resume" then
		--mgSetScale(resumeUi, 1, 1, "easeout", 0.15)
		--mgSetAlpha(resumeUi, 1, "easeout", 0.15)
		--mgSetUiModal(resumeUi, true)
		handleCommand("showpausemenu")
	end

	if cmd == "hideresume" then
		mgSetScale(resumeUi, 0, 0, "easein", 0.15)
		mgSetAlpha(resumeUi, 0, "easein", 0.15)
		mgCommand("game.resume")
		mgSetUiModal(resumeUi, false)
	end	

	if getFirst(cmd) == "powerup" then
		name = getSecond(cmd)
		if name ~= currentPowerup then
			mgCommand("game.powerup " .. name)
		end
	end
	
	if getFirst(cmd) == "pickup" then
		value = getSecond(cmd)
		mgSetText(pickupText, "<" .. value)
		mgSetOrigo(pickupText, "center")
		mgSetScale(pickupText, 0, 0)
		mgSetScale(pickupText, 0.9, 0.9, "easeout", 0.2)
		if mode == MODE_VERSUS then
			if tonumber(mgGet("level.lastpickup")) == 0 then
				mgSetRot(pickupText, -math.pi/2)
				mgSetPos(pickupText, centerX-100, centerY+300)
				mgSetPos(pickupText, centerX-100, centerY+500, "linear", 0.8)
			else
				mgSetRot(pickupText, math.pi/2)
				mgSetPos(pickupText, centerX+100, centerY-300)
				mgSetPos(pickupText, centerX+100, centerY-500, "linear", 0.8)
			end
		else
			mgSetPos(pickupText, centerX+180, top+100)
			mgSetPos(pickupText, centerX+250, top+100, "linear", 0.8)
		end
		mgSetAlpha(pickupText, 1)
		mgSetAlpha(pickupText, 0, "easein", 0.8)
	end

	if cmd == "showupgrade" then
		mgRunDelayed('showupgrade()', 0.6)
	end
	
	if cmd == "exit" then
		mgSetScale(pauseMenuUi, 0, 0, "easeout", 0.2)
		mgSetScale(resumeUi, 0, 0, "easeout", 0.2)
	end
	
	if cmd == "hideupgrade" then
		upgradePopup.hide(upgradePopupObj, false)
	end
	if cmd == "hideupgradeinstant" then
		upgradePopup.hide(upgradePopupObj, true)
	end
	
	if cmd == "showoutofballs" then
		outOfBallsPopup.show(outOfBallsPopupObj, uiScale)
	end

	if cmd == "hideoutofballs" then
		outOfBallsPopup.hide(outOfBallsPopupObj)
	end

	if cmd == "pushPowerup" then
		pushPowerup()			
	end

	if cmd == "popPowerup" then
		popPowerup()			
	end

	if cmd == "hintfrenzy" and not zen and not expert then
		hintFrenzy = mgCreateImage("hint_swipe.png")
		mgSetOrigo(hintFrenzy, "center")
		mgSetPos(hintFrenzy, centerX, centerY)
		mgSetScale(hintFrenzy, 1.333)
		mgSetAlpha(hintFrenzy, 0)
		mgSetAlpha(hintFrenzy, 1, "linear", 0.4)
		hintFrenzyHand = mgCreateImage("hint_swipe_hand.png")
		hintFrenzyHandGuide = mgCreateImage("hint_swipe_hand.png", 0, 0, 0, 0)
		mgSetOrigo(hintFrenzyHand, "center")
		mgSetPos(hintFrenzyHandGuide, centerX-300, centerY+200)
		mgSetAlpha(hintFrenzyHand, 0)
		mgSetAlpha(hintFrenzyHand, 1, "linear", 0.4)
		mgRunDelayed('mgSetPos(hintFrenzyHandGuide, centerX+500, centerY+200, "cosine", 1.5)', 0.4)
		hintFrenzyBall = mgCreateImage("hint_swipe_ball.png")
		mgSetOrigo(hintFrenzyBall, "center")
		mgSet("game.paused", 1)
	end

	if cmd == "hintpowerup" then
		hintArrow = mgCreateImage("hint_arrow.png")
		mgSetOrigo(hintArrow, "center")
		mgSetAlpha(hintArrow, 0.001)
		mgSetAlpha(hintArrow, 1, "linear", 0.4)
	end

	if cmd == "back" then
		if upgradePopup.is_visible(upgradePopupObj) then
			handleCommand("hideupgrade")
			mgCommand("game.menu")
		elseif outOfBallsPopup.is_visible(outOfBallsPopupObj) then
			handleCommand("hideoutofballs")
		elseif mgGetAlpha(pauseMenuUi) > 0 then
			handleCommand("hidepausemenu")
		elseif mgGetAlpha(resumeUi) > 0 then
			handleCommand("hideresume")
		elseif mgGet("level.credits") == "1" then
			mgCommand("game.menu")
		else
			if mgGet("game.platform") == "android" then
				handleCommand("showpausemenu")
			end			
		end
	end
	
	if getFirst(cmd) == "miss" then
		pos = getSecond(cmd)
		if pos == "left" then mgSetPos(hintMiss, left+300, centerY)
		elseif pos == "right" then mgSetPos(hintMiss, right-300, centerY)
		else mgSetPos(hintMiss, centerX, bottom-300) end
		mgSetScale(hintMiss, 0, 0)
		mgSetScale(hintMiss, 2, 2, "easeout", 0.15)
		mgSetAlpha(hintMiss, 0)
		mgSetAlpha(hintMiss, 1, "linear", 0.15)
		mgRunDelayed('mgSetScale(hintMiss, 0, 0, "easein", 0.15)', 0.9)
		mgRunDelayed('mgSetAlpha(hintMiss, 0, "linear", 0.15)', 0.9)
	end
	
	if cmd == "granny" then
		if mgGet("game.platform") == "android" then
			mgCommand("game.url http://play.google.com/store/apps/details?id=com.mediocre.grannysmith")
		else
			mgCommand("game.url https://itunes.apple.com/us/app/granny-smith/id529096189?mt=8")
		end
	end

	if cmd == "sprinkle" then
		if mgGet("game.platform") == "android" then
			mgCommand("game.url http://play.google.com/store/apps/details?id=com.mediocre.sprinkleislands")
		else
			mgCommand("game.url https://itunes.apple.com/us/app/sprinkle-islands/id603529731?mt=8")
		end
	end

	if cmd == "licenses" then
		mgCommand("game.url https://mediocre.se/licenses.html")
	end
end

function showupgrade()
	local areAdsEnabled = mgGetRemoteConfigBoolParameter("smashhit_ads_enabled_cp")
	local isAdLoaded = mgIsCheckpointAdLoaded()
	mgCommand("game.ad_popup_shown start_checkpoint_2_non_premium")
	handleCommand("hidepausemenu")
	upgradePopup.show(upgradePopupObj, uiScale)
end
