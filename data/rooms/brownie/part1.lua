function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1, 1.2, 1.4, .4, -.3, -.5)
	mgMusic("32")
	mgLowPass(0.2)
	mgReverb(0.2, 0.5, 0.2) 
	mgEcho(0.2, 0.5, 0.75, 0.8) 
	mgGravity(.8)
	
	confSegment("brownie/part1/16_0", 1)
	confSegment("brownie/part1/16_1", 1)
	confSegment("brownie/part1/16_2", 1, 2)
	confSegment("brownie/part1/16_3", 1)

	
	l = 0
	
	if pStart then
		l = l + mgSegment("brownie/part1/start", -l)	
	end
	
	local targetLen = 120 
	if mgGet("player.mode")=="0" then targetLen = 90 end
	if mgGet("player.mode")=="2" then targetLen = 130 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("brownie/part1/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
