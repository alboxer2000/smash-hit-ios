function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("44") 
	mgReverb(0.7, 0.25, 0.6)
	mgLowPass(0.3)
	mgEcho(0.2, 0.15, 0.7, 0.85)
	mgFogColor(-.5, -.1, .4, 1, 1.4, .7)
	
	confSegment("split/split2/16_0_coop", 1)
	confSegment("split/split2/16_1", 1)
	confSegment("split/split2/16_2_coop", 1)
	confSegment("split/split2/16_3_coop", 1)
	confSegment("split/split2/16_suspend_coop", 1)

	l = 0
	
	if pStart then
		l = l + mgSegment("split/split2/start", -l)	
	end
	
	while l < 60 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	
	l = l + mgSegment("split/split2/16_0_coop", -l)	
	

	local targetLen = 150 
	targetLen = targetLen + mgGetSplitExtraRoomLength()
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("split/split2/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
