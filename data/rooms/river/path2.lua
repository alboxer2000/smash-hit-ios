function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.55, 1.1, 1.1, 0, .25, .2)
	mgMusic("3") 
	mgReverb(0.15, 0.9, 0.15)

	confSegment("river/path2/16_0", 1)
	confSegment("river/path2/16_1", 1)
	confSegment("river/path2/16_2", 1)
	confSegment("river/path2/16_3", 1, 1)
	confSegment("river/path2/16_4", 1, 1)
	confSegment("river/path2/16_5", 1, 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("river/path2/start", -l)	
	end
	
	local len = 200
	if mgGet("player.mode")=="0" then len = 150 end
	if mgGet("player.mode")=="2" then len = 200 end
	while l < len do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("river/path2/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
