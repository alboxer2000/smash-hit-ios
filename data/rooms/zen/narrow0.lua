function init()
	pLength = mgGetInt("length", 120)
	pRot = mgGetBool("rot", true)

	local r = math.random(5)
	
    if r == 1 then
		mgFogColor(.5, 1.6, 1.6, -.1, 0, -.1)
		mgMusic("34")
		if pRot then mgSetRotation(1, 4) end
    elseif r == 2 then
		mgFogColor(-.3, 0, .1, 1.1, 1.6, 1.1)
		mgMusic("33")
		if pRot then mgSetRotation(2, 2) end
    elseif r == 3 then
		mgFogColor(1.7, 1.4, 1.1, -.3, -.8, -.1)
		mgMusic("31")
		if pRot then mgSetRotation(1, 1) end
    elseif r == 4 then
		mgFogColor(-.3, -1.5, .3, 1.2, 1.3, 1.1)
		mgMusic("32")
    elseif r == 5 then
		if pRot then mgSetRotation(1, 2) end
		mgFogColor(1.4, 1.5, 1.1, 0, -.2, .1)
		mgMusic("21")
    end
	
	mgLowPass(0.2)
	mgReverb(.6, 0.2, 0.3) 
	mgEcho(0.9, 0.2, 0.3, 0.8)
	mgParticles("starfield")
	mgGravity(0)

	confSegment("zen/narrow/fillers/8_0", .1)
	confSegment("zen/narrow/fillers/8_2", .25)
	confSegment("zen/narrow/fillers/8_3", .25)
	confSegment("zen/narrow/fillers/16_0", .25)
	confSegment("zen/narrow/fillers/16_1", .1)

	confSegment("zen/narrow/obstacles/8_beatmill", 1)
	confSegment("zen/narrow/obstacles/8_pyramid", 1)
	confSegment("zen/narrow/obstacles/8_suspendside", 1)
	confSegment("zen/narrow/obstacles/16_cranks_x2", 1)
	confSegment("zen/narrow/obstacles/16_pendulums_x2", 1)
	confSegment("zen/narrow/obstacles/fall_0", 1)
	confSegment("zen/narrow/obstacles/fall_1", 1)	
	
	confSegment("zen/narrow/scores/16_scoretops_x8", 0.25)
	confSegment("zen/narrow/scores/16_scoretops_x6", 0.25)
	confSegment("zen/narrow/scores/16_scoretops_x6_2", 0.5)
	confSegment("zen/narrow/scores/16_scoretops_x4", 0.5)
	confSegment("zen/narrow/scores/8_scoretops_x2", .125)
	confSegment("zen/narrow/scores/8_scoretop", 0.5)
	confSegment("zen/narrow/scores/8_scoretop2", .25)
	confSegment("zen/narrow/scores/8_scoretop3", .25)
	confSegment("zen/narrow/scores/8_scoretop4", .25)
		
	l = 0
	l = l + mgSegment("zen/narrow/start", -l)	

	while l < pLength do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	l = l + mgSegment("zen/narrow/door", -l)
	
	mgLength(l)
end

function tick()
end
