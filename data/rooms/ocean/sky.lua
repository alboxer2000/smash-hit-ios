function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(.7, 1.5, 1.5, 0, -.3, .1)
	mgMusic("22")
	mgLowPass(0.6)
	mgReverb(0.2, 0.5, 0.2) 
	mgEcho(0.4, 0.5, 0.75, 0.8) 
	mgGravity(.4)
	mgParticles("bubbles")
	
	confSegment("ocean/sky/16_0", 1)
	confSegment("ocean/sky/4_0", 1)
	confSegment("ocean/sky/8_0", 1)
	confSegment("ocean/sky/8_1", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("ocean/sky/start", -l)	
	end
	
	local targetLen = 200 
	if mgGet("player.mode")=="0" then targetLen = 150 end
	if mgGet("player.mode")=="2" then targetLen = 240 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("ocean/sky/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
