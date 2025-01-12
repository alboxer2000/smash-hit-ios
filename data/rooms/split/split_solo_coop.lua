function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("19") 
	mgReverb(0.7, 0.25, 0.6)
	mgLowPass(0.3)
	mgEcho(0.2, 0.15, 0.7, 0.85)
	mgFogColor(.2, -.2, .1, .4, 1, 2)
	mgParticles("bubbles")
	mgGravity(.4)
		
	confSegment("split/solo/16_0_coop", 1)
	confSegment("split/solo/16_1", 1)
	confSegment("split/solo/16_2_coop", 1)
	confSegment("split/solo/16_3", 1)
	confSegment("split/solo/16_4_coop", 1)
	confSegment("split/solo/8_0", 1)
	confSegment("split/solo/8_1", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("split/solo/start", -l)	
	end
	
	while l < 60 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	
	l = l + mgSegment("split/solo/16_0_coop", -l)	

	local targetLen = 120 
	targetLen = targetLen + mgGetSplitExtraRoomLength()
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("split/solo/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
