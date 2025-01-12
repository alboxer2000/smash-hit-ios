function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(.6, 1.2, 1.4, .3, -1, -1.2)
	mgMusic("17")
	mgLowPass(0.2)
	mgReverb(0.2, 0.5, 0.2) 
	mgEcho(0.3, 0.5, 0.75, 0.8) 
	mgGravity(.8)
	
	confSegment("brownie/part3/16_0", 1)
	confSegment("brownie/part3/16_1", 1)
	confSegment("brownie/part3/16_2", 1)
	confSegment("brownie/part3/16_3", .25)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("brownie/part3/start", -l)	
	end
	
	local targetLen = 100 
	if mgGet("player.mode")=="0" then targetLen = 80 end
	if mgGet("player.mode")=="2" then targetLen = 100 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("brownie/part3/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
