function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1, 1.3, 2, .1, 0, 0)
	mgMusic("35")
	mgReverb(.3, 0.6, 0.1) 
	mgEcho(0.3, 0.4, 0.2, 0.1)
	mgGravity(0)
	mgParticles("starfield")
	
	confSegment("hyperspace/cruise/32_0", 1)
	confSegment("hyperspace/cruise/32_1", 1)
	confSegment("hyperspace/cruise/32_2", 1)
	confSegment("hyperspace/cruise/32_3", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("hyperspace/cruise/start", -l)	
	end

	local targetLen = 130 
	if mgGet("player.mode")=="0" then targetLen = 100 end
	if mgGet("player.mode")=="2" then targetLen = 130 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("hyperspace/cruise/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
