function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.55, 1.1, 1.1, 0, .25, .2)
	mgMusic("16") 
	mgReverb(0.2, 0.5, 0.2)
	mgEcho(0.1, 0.3, 0.7, 0.4) 

	confSegment("river/tunnel/crank", 1)
	confSegment("river/tunnel/crank2", 1, 2)
	confSegment("river/tunnel/hammer", 1)
	confSegment("river/tunnel/hammer2", 1, 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("river/tunnel/start", -l)	
	end
	
	local len = 170
	if mgGet("player.mode")=="0" then len = 140 end
	if mgGet("player.mode")=="2" then len = 200 end
	while l < len do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("river/tunnel/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
