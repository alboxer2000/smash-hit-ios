function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("1") 
	mgReverb(0.15, 0.8, 0.1)
	mgEcho(0.4, 0.4, 0.5, 0.5)
	mgFogColor(1.8, 1.4, 1.4, 0, .5, .4)

	confSegment("basic/dark/bs", 1)
	confSegment("basic/dark/bs_extraballs", 1)
	confSegment("basic/dark/2_bs", 1)
	confSegment("basic/dark/2_bs_elevators", 1)
	confSegment("basic/dark/ledges", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("basic/dark/start", -l)	
	end
	
	local targetLen = 140 
	if mgGet("player.mode")=="0" then targetLen = 120 end
	if mgGet("player.mode")=="2" then targetLen = 200 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("basic/dark/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
