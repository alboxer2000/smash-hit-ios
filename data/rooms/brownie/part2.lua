function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.2, 1.8, 2, .1, -1, -1.2)
	mgMusic("3")
	mgLowPass(0.2)
	mgReverb(0.2, 0.5, 0.2) 
	mgEcho(0.2, 0.4, 0.55, 0.8) 
	mgGravity(.8)
	
	confSegment("brownie/part2/16_0", 1)
	confSegment("brownie/part2/16_1", 1)
	confSegment("brownie/part2/16_2", 1, 1)
	confSegment("brownie/part2/16_3", 1, 2)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("brownie/part2/start", -l)	
	end
	
	local targetLen = 170 
	if mgGet("player.mode")=="0" then targetLen = 130 end
	if mgGet("player.mode")=="2" then targetLen = 170 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("brownie/part2/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
