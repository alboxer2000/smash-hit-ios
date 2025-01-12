function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(0, -.2, .4, 1.2, 1.3, .9)
	mgMusic("13")
	mgReverb(.4, 0.2, 0.0) 
	mgEcho(0.5, 0.6, 0.4, 0.7)
	mgSetRotation(-1)
	
	confSegment("cave/spin/16_0", 1)
	confSegment("cave/spin/16_1", 1)
	confSegment("cave/spin/16_2", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("cave/spin/start", -l)	
	end
	
	local targetLen = 170 
	if mgGet("player.mode")=="0" then len = 140 end
	if mgGet("player.mode")=="2" then len = 230 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("cave/spin/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
