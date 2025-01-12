function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("41") 
	mgReverb(0.7, 0.25, 0.6)
	mgLowPass(0.3)
	mgEcho(0.2, 0.15, 0.7, 0.85)
	mgFogColor(1.8, 1.2, 1, -.4, 0, 0)
	mgParticles("lowrising")
		
	confSegment("split/split_start/16_0_coop", 1)
	confSegment("split/split_start/16_1_coop", 1)
	confSegment("split/split_start/16_2", 1)
	confSegment("split/split_start/16_3_coop", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("split/split_start/start", -l)	
	end
	
	while l < 60 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	
	l = l + mgSegment("split/split_start/16_0_coop", -l)	
	

	local targetLen = 140 
	targetLen = targetLen + mgGetSplitExtraRoomLength()
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("split/split_start/door_coop", -l)	
	end
		
	mgLength(l)
end

function tick()
end
