function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(0, -.2, .4, 1.2, 1.3, .9)
	if pStart then
		mgRandomize(0)
	end
	mgMusic("33")
	mgReverb(0.3, 0.2, 0.7) 
	mgEcho(0.4, 0.1, 0.5, 0.8)

	confSegment("cave/narrow/16_0", 1)
	confSegment("cave/narrow/16_1", 1)
	confSegment("cave/narrow/16_2", 1)
	confSegment("cave/narrow/16_3", 1)
	confSegment("cave/narrow/8_0", 1)
	confSegment("cave/narrow/8_1", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("cave/narrow/start", -l)	
	end
	
	local len = 170
	if pEnd then
		len = 200
	end
	while l < len do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("cave/narrow/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
