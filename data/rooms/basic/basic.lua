function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("0")
	mgReverb(0.2, 0.8, 0.3)
	mgEcho(0.3, 0.2, 0.5, 0.5)
	mgFogColor(1.8, 1.6, 1.9, .05, .3, 0)

	confSegment("basic/basic/chasms", 1)
	confSegment("basic/basic/chasms2", 1)
	confSegment("basic/basic/stairs", 1)
	confSegment("basic/basic/stairs2", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("basic/basic/start", -l)	
	end

	local targetLen = 140 
	if mgGet("player.mode")=="0" then targetLen = 120 end
	if mgGet("player.mode")=="2" then targetLen = 200 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("basic/basic/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
