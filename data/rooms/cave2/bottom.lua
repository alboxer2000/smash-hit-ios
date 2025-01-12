function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(.4, 0, .5, 1.3, .9, .6)
	mgMusic("8")
	mgReverb(.3, 0.8, 0.4) 
	mgEcho(0.2, 0.8, 0.3, 0.8)
	mgLowPass(0.3)
	mgParticles("fallinglite")

	confSegment("cave2/bottom/16_0", 1)
	confSegment("cave2/bottom/16_1", 1)
	confSegment("cave2/bottom/16_2", 1)
	confSegment("cave2/bottom/16_3", 1)
	confSegment("cave2/bottom/16_4", 1)
	confSegment("cave2/bottom/16_5", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("cave2/bottom/start", -l)	
	end
	
	local targetLen = 150 
	if mgGet("player.mode")=="0" then targetLen = 110 end
	if mgGet("player.mode")=="2" then targetLen = 170 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)
	end

	if pEnd then 
		l = l + mgSegment("cave2/bottom/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
