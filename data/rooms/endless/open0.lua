function init()
	pEndless = mgGetInt("endless", 0)
	pLength = mgGetInt("length", 150)

	local t = pEndless/10.0 if t > 1 then t = 1 end
	mgFogColor(1, 1-t, 1-t, t, t, 0)

	mgMusic("5")
	mgLowPass(0.2)
	mgReverb(.1, 0.9, 0.1) 
	mgEcho(0.4, 0.3, 0.7, 0.9)

	if pEndless > 5 then
		mgSetRotation(-1)
	end
	if pEndless > 10 then
		mgSetRotation(2)
	end

	local p = 1.0 - pEndless*0.1
	if p < 0 then p = 0 end

	local difficulty = pEndless*0.1
	if difficulty > 1 then difficulty = 1 end
	local invDifficulty = 1-difficulty
	mgSetDifficulty(difficulty)

	--confSegment("endless/open/fillers/8_0", .5)
	--confSegment("endless/open/fillers/8_1", .5)
	--confSegment("endless/open/fillers/8_2", .1)
	--confSegment("endless/open/fillers/8_3", .1)
	--confSegment("endless/open/fillers/16_0", .5)
	--confSegment("endless/open/fillers/16_1", .1)

	confSegment("endless/open/obstacles/16_sweepers_x2", 1)
	confSegment("endless/open/obstacles/8_suspendwindow", 1)
	confSegment("endless/open/obstacles/8_rotor", 1)
	confSegment("endless/open/obstacles/8_rotor2", 1)
	confSegment("endless/open/obstacles/8_foldwindow", 1)
	confSegment("endless/open/obstacles/8_foldwindow2", 1)
	
	confSegment("endless/open/scores/16_scoretops_x6", .125 * invDifficulty)
	confSegment("endless/open/scores/16_scoretops_x4", .25 * invDifficulty)
	confSegment("endless/open/scores/16_scoretops_x4_2", .25 * invDifficulty)
	confSegment("endless/open/scores/8_scoretops_x2", 0.5 * invDifficulty)
	confSegment("endless/open/scores/8_scoretop", 0.5 * invDifficulty)
	confSegment("endless/open/scores/8_scoretop2", 0.5 * invDifficulty)
	
	confSegment("endless/open/powerups/8_ballfrenzy", 0.3 * invDifficulty)
	confSegment("endless/open/powerups/8_ballfrenzy2", .2 * invDifficulty)
	confSegment("endless/open/powerups/8_nitroballs", 0.3 * invDifficulty)
	confSegment("endless/open/powerups/8_nitroballs2", .1 * invDifficulty)
	confSegment("endless/open/powerups/8_slomo", .1 * invDifficulty)
	confSegment("endless/open/powerups/8_slomo2", .1 * invDifficulty)
	
	l = 0
	l = l + mgSegment("endless/open/start", -l)	
	
	while l < pLength do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	l = l + mgSegment("endless/open/door", -l)
	
	mgLength(l)
end

function tick()
end
