function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.4, 1.5, 1.2, -.4, .3, .3)
	mgMusic("26")
	mgLowPass(0.2)
	mgReverb(0.15, 0.6, 0.1) 
	mgEcho(0.2, 0.5, 0.6, 0.9) 
	mgGravity(.4)
	
	confSegment("phosphor/part1/16_0", 1)
	confSegment("phosphor/part1/16_1", 1)
	confSegment("phosphor/part1/16_2", 1)
	confSegment("phosphor/part1/16_3", 1)
	confSegment("phosphor/part1/16_4", 1)

	
	l = 0
	
	local len = 210
	if pStart then
		l = l + mgSegment("phosphor/part1/start", -l)	
		len = 180
	end
	
	if mgGet("player.mode")=="0" then len = len * 0.8 end
	if mgGet("player.mode")=="2" then len = len * 1 end

	while l < len do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("phosphor/part1/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
