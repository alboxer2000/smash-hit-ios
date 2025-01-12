function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("43") 
	mgReverb(0.7, 0.25, 0.6)
	mgLowPass(0.3)
	mgEcho(0.2, 0.15, 0.7, 0.85)
	mgGravity(0)
	mgSetRotation(-1)
	mgFogColor(1.6, 1.4, .3, -.4, -.1, .2)
	mgParticles("starfield")
		
	confSegment("split/split_rot/16_0_coop", 1)
	confSegment("split/split_rot/16_1", 1)
	confSegment("split/split_rot/16_2_coop", 1)
	confSegment("split/split_rot/16_3", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("split/split_rot/start_coop", -l)	
	end
	
	while l < 60 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	
	l = l + mgSegment("split/split_rot/16_0_coop", -l)	
	

	local targetLen = 120 
	targetLen = targetLen + mgGetSplitExtraRoomLength()
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("split/split_rot/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
