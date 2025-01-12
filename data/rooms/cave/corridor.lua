function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(0, -.2, .4, 1.2, 1.3, .9)
	mgMusic("18")
	mgReverb(0.3, 0.2, 0.7) 
	mgEcho(0.4, 0.1, 0.5, 0.8)

	confSegment("cave/corridor/16_0", 1)
	confSegment("cave/corridor/16_1", 1)
	confSegment("cave/corridor/16_2", 1)
	confSegment("cave/corridor/16_3", 1)
	confSegment("cave/corridor/8_0", .5)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("cave/corridor/start", -l)	
	end
	
	while l < 80 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	
	l = l + mgSegment("cave/corridor/start", -l)

	local targetLen = 180 
	if mgGet("player.mode")=="0" then targetLen = 140 end
	if mgGet("player.mode")=="2" then targetLen = 220 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("cave/corridor/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
