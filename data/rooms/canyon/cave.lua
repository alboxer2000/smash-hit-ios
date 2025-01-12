function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.4, 1.25, 1, .5, 0, .4)
	mgMusic("2")
	mgLowPass(0.2)
	mgReverb(.1, 0.4, 0.1) 
	mgEcho(0.6, 0.04, 0.3, 0.9)

	confSegment("canyon/cave/8_0", 1)
	confSegment("canyon/cave/16_0", 1)
	confSegment("canyon/cave/32_0", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("canyon/cave/start", -l)	
	end
	
	local targetLen = 180
	if mgGet("player.mode")=="0" then targetLen = 130 end
	if mgGet("player.mode")=="2" then targetLen = 220 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("canyon/cave/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
