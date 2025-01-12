function init()
	pEndless = mgGetInt("endless", 0)
	pLength = mgGetInt("length", 150)

	local t = pEndless/10.0 if t > 1 then t = 1 end
	mgFogColor(1, 1-t, 1-t, t, t, 0)

	mgMusic("25")
	mgLowPass(0.2)
	mgReverb(.6, 0.1, 0.3) 
	mgEcho(0.6, 0.5, 0.6, 0.2)

	mgSetRotation(1)
	if pEndless > 10 then
		mgSetRotation(-2)
	end


	local p = 1.0 - pEndless*0.1
	if p < 0 then p = 0 end

	local difficulty = pEndless*0.1
	if difficulty > 1 then difficulty = 1 end
	local invDifficulty = 1-difficulty
	mgSetDifficulty(difficulty)

	--confSegment("endless/space/fillers/16_0", .5)
	--confSegment("endless/space/fillers/16_1", .5)
	--confSegment("endless/space/fillers/16_2", .5)
	--confSegment("endless/space/fillers/16_3", .5)
	
	confSegment("endless/space/obstacles/16_0", 1)
	confSegment("endless/space/obstacles/16_1", 1)
	confSegment("endless/space/obstacles/16_2", 1)
	confSegment("endless/space/obstacles/16_3", 1)
	
	confSegment("endless/space/scores/16_0", 0.5)
	confSegment("endless/space/scores/16_1", 0.5)
	confSegment("endless/space/scores/16_2", 0.5)
	confSegment("endless/space/scores/16_3", 0.5)
	
	confSegment("endless/space/powerups/16_0", 0.3)
	confSegment("endless/space/powerups/16_1", 0.3)
	confSegment("endless/space/powerups/16_2",0.3)
	confSegment("endless/space/powerups/16_3", 0.3)

	l = 0
	l = l + mgSegment("endless/space/start", -l)	
	
	while l < pLength do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	l = l + mgSegment("endless/space/door", -l)
	
	mgLength(l)
end

function tick()
end
