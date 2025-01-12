function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.4, 1.25, 1, .5, 0, .4)
	mgMusic("20")
	mgReverb(0.1, 1.1, 0.05) 
	mgEcho(0.15, 0.7, 0.5, 0.5) 
	mgParticles("sidesrising")

	confSegment("canyon/trail/8_0", 1)
	confSegment("canyon/trail/16_0", .25)
	confSegment("canyon/trail/16_1", 1)
	confSegment("canyon/trail/16_2", .1)
	confSegment("canyon/trail/16_3", 1)
	confSegment("canyon/trail/32_0", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("canyon/trail/start", -l)	
	end
	
	local targetLen = 200 
	if mgGet("player.mode")=="0" then targetLen = 160 end
	if mgGet("player.mode")=="2" then targetLen = 200 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("canyon/trail/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
