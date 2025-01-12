function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("42_1") 
	mgReverb(0.7, 0.25, 0.6)
	mgLowPass(0.3)
	mgEcho(0.2, 0.15, 0.7, 0.85)
	mgFogColor(2, 1.2, .8, -.4, -.5, 0)
	mgParticles("lowrising")
		
	confSegment("split/split0/16_8st", 1)
	confSegment("split/split0/16_8st2", 1)
	confSegment("split/split0/16_8st3", 1)
	confSegment("split/split0/16_3rotors", 1)
	confSegment("split/split0/16_bars", 1)
	confSegment("split/split0/16_fold_diamond", 1)
	confSegment("split/split0/16_rotor", 1)
	confSegment("split/split0/16_sweeper", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("split/split0/start", -l)	
	end
	
	while l < 60 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	
	l = l + mgSegment("split/split0/16_st", -l)	
	

	local targetLen = 120 
	targetLen = targetLen + mgGetSplitExtraRoomLength()
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("split/split0/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
