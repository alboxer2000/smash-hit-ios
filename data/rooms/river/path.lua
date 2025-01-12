function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.55, 1.1, 1.1, 0, .25, .2)
	mgMusic("5") 
	mgReverb(0.15, 0.9, 0.15)
	
	confSegment("river/path/bar", 1)
	confSegment("river/path/bar_bounce", 1)
	confSegment("river/path/bounce", 1)
	confSegment("river/path/fly", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("river/path/start", -l)	
	end
	
	local len = 150
	if mgGet("player.mode")=="0" then len = 120 end
	if mgGet("player.mode")=="2" then len = 170 end
	while l < len do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("river/path/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
