function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(2, 1, 0, .1, -.2, 0)
	mgMusic("39")
	mgReverb(.2, 0.4, 0.3) 
	mgEcho(0.3, 0.3, 0.4, 0.3)
	mgGravity(0)
	mgSetRotation(1.4, 2)
	mgParticles("starfield")
	
	confSegment("city/fall/32_0", 1)
	confSegment("city/fall/32_1", 1)
	confSegment("city/fall/32_2", 1)
	confSegment("city/fall/32_3", 1)
	confSegment("city/fall/32_4", 2)
	confSegment("city/fall/32_5", 2)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("city/fall/start", -l)	
	end

	local targetLen = 160 
	if mgGet("player.mode")=="0" then targetLen = 120 end
	if mgGet("player.mode")=="2" then targetLen = 180 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("city/fall/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
