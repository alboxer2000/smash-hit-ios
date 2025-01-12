function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1, 1.3, 2, .1, 0, 0)
	mgMusic("36")
	mgReverb(.1, 0.6, 0.1) 
	mgEcho(0.8, 0.4, 0.2, 0.1)
	mgGravity(1)
	
	mgParticles("lowrising")

	confSegment("hyperspace/orbit/32_1", 1)
	confSegment("hyperspace/orbit/32_2", 1)
	confSegment("hyperspace/orbit/32_3", 1)
	confSegment("hyperspace/orbit/32_4", 1)
	confSegment("hyperspace/orbit/32_5", 1)
	confSegment("hyperspace/orbit/32_6", 1)
	confSegment("hyperspace/orbit/32_7", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("hyperspace/orbit/start", -l)	
	end

	local targetLen = 180 
	if mgGet("player.mode")=="0" then targetLen = 140 end
	if mgGet("player.mode")=="2" then targetLen = 190 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("hyperspace/orbit/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
