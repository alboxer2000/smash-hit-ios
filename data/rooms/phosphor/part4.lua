function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.4, 1.5, 1.2, -.4, .3, .3)
	mgMusic("29_2")
	mgLowPass(0.2)
	mgReverb(0.0, 0.5, 0.2) 
	mgEcho(0.5, 0.5, 0.6, 0.8) 
	mgGravity(.4)
	mgSetRotation(-1)

	confSegment("phosphor/part4/16_0", 1)
	confSegment("phosphor/part4/16_1", 1)
	confSegment("phosphor/part4/16_2", 1)
	confSegment("phosphor/part4/16_3", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("phosphor/part4/start", -l)	
	end
	
	len = 180
	if mgGet("player.mode")=="0" then len = 150 end
	if mgGet("player.mode")=="2" then len = 200 end
	
	while l < len do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("phosphor/part4/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
