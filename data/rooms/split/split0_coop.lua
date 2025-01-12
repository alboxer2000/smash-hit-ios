function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("42_1") 
	mgReverb(0.7, 0.25, 0.6)
	mgLowPass(0.3)
	mgEcho(0.2, 0.15, 0.7, 0.85)
	mgFogColor(1.9, 1.2, .9, -.4, -.25, 0)
	mgParticles("lowrising")
		
	confSegment("split/split0/16_8st2", 1)
	confSegment("split/split0/16_8st3", 1)
	confSegment("split/split0/16_3rotors", 1)
	confSegment("split/split0/16_bars_coop", 1)
	confSegment("split/split0/16_bar_coop", 1)
	confSegment("split/split0/16_fold_diamond_coop", 1)
	confSegment("split/split0/16_laserbars_coop", 1)
	confSegment("split/split0/16_rotor_coop", 1)
	confSegment("split/split0/16_sweeper", 1)

	l = 0
	
	if pStart then
		l = l + mgSegment("split/split0/start_coop", -l)	
	end
	
	while l < 60 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	
	l = l + mgSegment("split/split0/16_st_coop", -l)	
	

	local targetLen = 140 
	targetLen = targetLen + mgGetSplitExtraRoomLength()
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("split/split0/door_coop", -l)	
	end
		
	mgLength(l)
end

function tick()
end
