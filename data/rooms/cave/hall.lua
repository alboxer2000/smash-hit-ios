function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(0, -.1, .3, 1.1, 1.15, .9)
	mgMusic("24")
	mgReverb(0.3, 0.9, 0.4) 
	mgEcho(0.2, 0.7, 0.5, 0.4)
	mgParticles("dustyfalling")

	confSegment("cave/hall/32_0", 1)
	confSegment("cave/hall/16_1", 2, 1)
	confSegment("cave/hall/16_2", 1)
	confSegment("cave/hall/16_3", 1)
	confSegment("cave/hall/8_0", 1)
	confSegment("cave/hall/8_1", 2, 1)
	confSegment("cave/hall/8_2", 2, 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("cave/hall/start", -l)	
	end
	
	local targetLen = 160 
	if mgGet("player.mode")=="0" then targetLen = 120 end
	if mgGet("player.mode")=="2" then targetLen = 140 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("cave/hall/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
