function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(.4, 0, .5, 1.3, .9, .6)
	mgMusic("31")
	mgReverb(.3, 0.8, 0.4) 
	mgEcho(0.4, 0.2, 0.6, 0.4)
	mgLowPass(0.3)

	confSegment("cave2/narrow/16_0", 1)
	confSegment("cave2/narrow/16_1", 1)
	confSegment("cave2/narrow/16_2", 1)
	confSegment("cave2/narrow/16_3", 1)
	confSegment("cave2/narrow/16_4", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("cave2/narrow/start", -l)	
	end
	
	local targetLen = 200 
	if mgGet("player.mode")=="0" then targetLen = 160 end
	if mgGet("player.mode")=="2" then targetLen = 220 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("cave2/narrow/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
