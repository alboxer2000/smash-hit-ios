function init()
	pEndless = mgGetInt("endless", 0)
	pLength = mgGetInt("length", 150)

	local t = pEndless/10.0 if t > 1 then t = 1 end
	mgFogColor(1, 1-t, 1-t, t, t, 0)

	mgMusic("30")
	mgLowPass(0.2)
	mgReverb(.3, 0.6, 0.3) 
	mgEcho(0.4, 0.04, 0.7, 0.9)

	local p = 1.0 - pEndless*0.1
	if p < 0 then p = 0 end

	local difficulty = pEndless*0.1
	if difficulty > 1 then difficulty = 1 end
	local invDifficulty = 1-difficulty
	mgSetDifficulty(difficulty)

	--confSegment("endless/wide/fillers/8_1", .5)
	--confSegment("endless/wide/fillers/8_2", .5)
	--confSegment("endless/wide/fillers/8_3", 1)
	
	confSegment("endless/wide/obstacles/16_lasers", 1)
	confSegment("endless/wide/obstacles/16_lasers2", 1)
	confSegment("endless/wide/obstacles/16_dropblocks", .5)
	confSegment("endless/wide/obstacles/8_suspendcube", 1)
	confSegment("endless/wide/obstacles/8_revolver", .75)
	confSegment("endless/wide/obstacles/8_revolver2", .25)
	
	confSegment("endless/wide/scores/16_scoretops_x8", 0.5 * invDifficulty)
	confSegment("endless/wide/scores/16_scoretops_x6", .25 * invDifficulty)
	confSegment("endless/wide/scores/8_scoretop3", .25 * invDifficulty)
	confSegment("endless/wide/scores/8_scoretop4", .25 * invDifficulty)
	
	confSegment("endless/wide/powerups/8_ballfrenzy", .2)
	confSegment("endless/wide/powerups/8_ballfrenzy2", .2)
	confSegment("endless/wide/powerups/8_nitro", .1)
	
	l = 0
	l = l + mgSegment("endless/wide/start", -l)	
	
	while l < pLength do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	l = l + mgSegment("endless/wide/door", -l)

	mgLength(l)
end

function tick()
end
