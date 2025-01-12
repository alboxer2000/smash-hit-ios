function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(.5, 1.7, 1.75, .2, -.65, -.2)
	mgMusic("38_1")
	mgReverb(.3, 0.6, 0.1) 
	mgEcho(0.3, 0.4, 0.2, 0.1)
	mgGravity(.75)
	mgParticles("lowrising")
	
	confSegment("city/path/16_0", 1)
	confSegment("city/path/16_1", 1)
	confSegment("city/path/16_2", 1)
	confSegment("city/path/16_3", 1)
	confSegment("city/path/16_4", .5)
	confSegment("city/path/16_5", .5)
	
	l = 0

	if pStart then
		l = l + mgSegment("city/path/start", -l)	
	end

	local targetLen = 130 
	if mgGet("player.mode")=="0" then targetLen = 100 end
	if mgGet("player.mode")=="2" then targetLen = 150 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("city/path/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
