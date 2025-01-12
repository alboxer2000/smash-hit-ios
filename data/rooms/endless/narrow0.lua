function init()
	pEndless = mgGetInt("endless", 0)
	pLength = mgGetInt("length", 150)

	local t = pEndless/10.0 if t > 1 then t = 1 end
	mgFogColor(1, 1-t, 1-t, t, t, 0)

	mgMusic("4")
	mgLowPass(0.2)
	mgReverb(.6, 0.2, 0.3) 
	mgEcho(0.9, 0.2, 0.3, 0.8)
	
	local p = 1.0 - pEndless*0.1
	if p < 0 then p = 0 end

	local difficulty = pEndless*0.1
	if difficulty > 1 then difficulty = 1 end
	local invDifficulty = 1-difficulty
	mgSetDifficulty(difficulty)

	--confSegment("endless/narrow/fillers/8_0", .1)
	--confSegment("endless/narrow/fillers/8_2", .25)
	--confSegment("endless/narrow/fillers/8_3", .25)
	--confSegment("endless/narrow/fillers/16_0", .25)
	--confSegment("endless/narrow/fillers/16_1", .1)
	
	confSegment("endless/narrow/obstacles/16_pendulums_x2", 1)
	confSegment("endless/narrow/obstacles/16_flycubes_x2", 1)
	confSegment("endless/narrow/obstacles/16_cranks_x2", 1)
	confSegment("endless/narrow/obstacles/8_suspendside", 1)
	confSegment("endless/narrow/obstacles/8_suspendbox", 1)
	confSegment("endless/narrow/obstacles/8_pyramid", .5)
	confSegment("endless/narrow/obstacles/8_beatmill", 1)
	
	confSegment("endless/narrow/scores/16_scoretops_x8", 0.25 * invDifficulty)
	confSegment("endless/narrow/scores/16_scoretops_x6", 0.25 * invDifficulty)
	confSegment("endless/narrow/scores/16_scoretops_x6_2", 0.5 * invDifficulty)
	confSegment("endless/narrow/scores/16_scoretops_x4", 0.5 * invDifficulty)
	confSegment("endless/narrow/scores/8_scoretops_x2", .125 * invDifficulty)
	confSegment("endless/narrow/scores/8_scoretop", 0.5 * invDifficulty)
	confSegment("endless/narrow/scores/8_scoretop2", .25 * invDifficulty)
	confSegment("endless/narrow/scores/8_scoretop3", .25 * invDifficulty)
	confSegment("endless/narrow/scores/8_scoretop4", .25 * invDifficulty)
	
	confSegment("endless/narrow/powerups/8_ballfrenzy", 0.3 * invDifficulty)
	confSegment("endless/narrow/powerups/8_ballfrenzy2", .1 * invDifficulty)
	confSegment("endless/narrow/powerups/8_nitroballs", .1 * invDifficulty)
	confSegment("endless/narrow/powerups/8_nitroballs2", .1 * invDifficulty)
	
	l = 0
	l = l + mgSegment("endless/narrow/start", -l)	

	while l < pLength do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	l = l + mgSegment("endless/narrow/door", -l)
	
	mgLength(l)
end

function tick()
end
