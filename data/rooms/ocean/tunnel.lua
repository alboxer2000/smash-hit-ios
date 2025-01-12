function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(.7, 1.5, 1.5, 0, -.3, .1)
	mgMusic("19")
	mgLowPass(0.75)
	mgReverb(0.2, 0.3, 0.2) 
	mgEcho(0.6, 0.4, 0.9, 0.95) 
	mgGravity(.4)
	mgSetRotation(1)
	
	confSegment("ocean/tunnel/16_0", 1)
	confSegment("ocean/tunnel/16_1", 1)
	confSegment("ocean/tunnel/16_2", 1)
	confSegment("ocean/tunnel/4_0", 1)
	confSegment("ocean/tunnel/4_1", .5)
	confSegment("ocean/tunnel/8_0", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("ocean/tunnel/start", -l)	
	end
	
	local targetLen = 190 
	if mgGet("player.mode")=="0" then targetLen = 150 end
	if mgGet("player.mode")=="2" then targetLen = 210 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("ocean/tunnel/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
