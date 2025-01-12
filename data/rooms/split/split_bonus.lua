function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("5") 
	mgReverb(0.7, 0.25, 0.6)
	mgLowPass(0.3)
	mgEcho(0.2, 0.15, 0.7, 0.85)
	mgFogColor(0, -.3, .05, .9, 1, 1.6)
	mgParticles("bubbles")
	mgGravity(.4)

	confSegment("split/split_bonus/8", 1)
	confSegment("split/split_bonus/8_2", 1)
	confSegment("split/split_bonus/16", 1)
	confSegment("split/split_bonus/16_2", 1)
	confSegment("split/split_bonus/16_3", 1)
	confSegment("split/split_bonus/16_blocks", 1)
	confSegment("split/split_bonus/16_gate", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("split/split_bonus/start", -l)	
	end
	
	while l < 60 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	
	l = l + mgSegment("split/split_bonus/8", -l)	
	

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
