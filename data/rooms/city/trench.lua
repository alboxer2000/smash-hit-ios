function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(2, 1, 0, .1, -.2, 0)
	mgMusic("37")
	mgReverb(.3, 0.6, 0.1) 
	mgEcho(0.3, 0.4, 0.2, 0.1)
	mgGravity(1)
	mgParticles("lowrising")
	
	confSegment("city/trench/16_0", 1)
	confSegment("city/trench/16_1", 1)
	confSegment("city/trench/16_2", 1)
	confSegment("city/trench/16_3", 1)
	confSegment("city/trench/16_4", 1)
	confSegment("city/trench/16_5", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("city/trench/start", -l)	
	end

	local targetLen = 200 
	if mgGet("player.mode")=="0" then targetLen = 160 end
	if mgGet("player.mode")=="2" then targetLen = 220 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("city/trench/door", -l)	
	end
	
	mgLength(l)
end

function tick()
end
