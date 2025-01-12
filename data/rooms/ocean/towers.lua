function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(.7, 1.5, 1.5, 0, -.3, .1)
	mgMusic("27")
	mgLowPass(0.9)
	mgReverb(0.2, 0.5, 0.2) 
	mgEcho(0.9, 0.6, 0.7, 0.9) 
	mgGravity(.4)
	
	mgParticles("bubbles")

	confSegment("ocean/towers/16_0", 1, 3)
	confSegment("ocean/towers/16_1", 1)
	confSegment("ocean/towers/16_2", .5, 2)
	confSegment("ocean/towers/8_0", 1)
	confSegment("ocean/towers/8_1", 1)
	confSegment("ocean/towers/8_2", 1)
	confSegment("ocean/towers/8_3", 1.5, 4)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("ocean/towers/start", -l)	
	end
	
	local targetLen = 170 
	if mgGet("player.mode")=="0" then targetLen = 140 end
	if mgGet("player.mode")=="2" then targetLen = 190 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("ocean/towers/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
