function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.6, 1.4, 2, -.8, 0, 0)
	mgMusic("19")
	mgReverb(.3, 0.6, 0.1) 
	mgEcho(0.3, 0.4, 0.2, 0.1)

	confSegment("night/part1/elgrid_box", 1)
	confSegment("night/part1/elgrid_box2", 1)
	confSegment("night/part1/elgrid_st", 1, 1)
	confSegment("night/part1/elgrid_st_2", 1, 1)
	confSegment("night/part1/elgrid_st_3", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("night/part1/start", -l)	
	end

	local targetLen = 140 
	if mgGet("player.mode")=="0" then targetLen = 120 end
	if mgGet("player.mode")=="2" then targetLen = 170 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("night/part1/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
