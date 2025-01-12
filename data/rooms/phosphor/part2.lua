function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.4, 1.5, 1.2, -.4, .3, .3)
	mgMusic("7")
	mgLowPass(0.2)
	mgReverb(0.2, 0.7, 0.1) 
	mgEcho(0.5, 0.2, 0.5, 0.9) 
	mgGravity(.4)
	mgSetRotation(-1)
	
	confSegment("phosphor/part2/16_0", 1)
	confSegment("phosphor/part2/16_1", 1)
	confSegment("phosphor/part2/16_2", 1)
	confSegment("phosphor/part2/16_3", 1)
	confSegment("phosphor/part2/16_4", 1)
	
	l = 0
	
	local len = 190
	if pStart then
		l = l + mgSegment("phosphor/part2/start", -l)	
		len = 150
	end
	
	if mgGet("player.mode")=="0" then len = len * 0.8 end
	if mgGet("player.mode")=="2" then len = len * 1 end

	while l < len do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("phosphor/part2/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
