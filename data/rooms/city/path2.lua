function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(0, 1.6, 1.9, .2, -.8, -.2)
	mgMusic("38_2")
	mgReverb(.3, 0.6, 0.1) 
	mgEcho(0.3, 0.4, 0.2, 0.1)
	mgGravity(.75)
	mgSetRotation(1)	
	mgParticles("lowrising")
	
	confSegment("city/path2/16_0", 1)
	confSegment("city/path2/16_1", 1)
	confSegment("city/path2/16_2", 1)
	confSegment("city/path2/16_3", 1)
	
	l = 0

	if pStart then
		l = l + mgSegment("city/path2/start", -l)	
	end

	local targetLen = 130 
	if mgGet("player.mode")=="0" then targetLen = 100 end
	if mgGet("player.mode")=="2" then targetLen = 150 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd and mgGet("player.mode")~="2" then 
		l = l + mgSegment("city/path2/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
