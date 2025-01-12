function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.4, 1.25, 1, .5, 0, .4)
	mgMusic("32")
	mgReverb(0.1, 1.1, 0.05) 
	mgEcho(0.2, 0.7, 0.5, 0.5) 
	mgParticles("lowrising")

	confSegment("canyon/columns/4_0", .5)
	confSegment("canyon/columns/16_1", 1)
	confSegment("canyon/columns/16_2", .5)
	confSegment("canyon/columns/32_0", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("canyon/columns/start", -l)	
	end
	
	local targetLen = 150 
	if mgGet("player.mode")=="0" then targetLen = 110 end
	if mgGet("player.mode")=="2" then targetLen = 210 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("canyon/columns/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
