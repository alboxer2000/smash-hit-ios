function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(.7, 1.5, 1.5, 0, -.3, .1)
	mgMusic("23")
	mgLowPass(0.4)
	mgReverb(0.2, 0.5, 0.2) 
	mgEcho(0.4, 0.5, 0.7, 0.8) 
	mgGravity(.4)
	mgParticles("bubbles")

	confSegment("ocean/stairs/16_0", 1)
	confSegment("ocean/stairs/32_0", 1)
	confSegment("ocean/stairs/8_0", 1)
	confSegment("ocean/stairs/8_1", 1)
	confSegment("ocean/stairs/8_2", .2)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("ocean/stairs/start", -l)	
	end
	
	while l < 110 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("ocean/stairs/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
