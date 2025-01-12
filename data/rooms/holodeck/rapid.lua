function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1, 1.9, 2.2, .2, -.1, .3)
	mgMusic("12")
	mgLowPass(0.1)
	mgReverb(0.5, 0.15, 0.1) 
	mgEcho(0.2, 0.1, 0.6, 0.5)

	confSegment("holodeck/rapid0", 1)
	confSegment("holodeck/rapid1", 1)
	confSegment("holodeck/rapid2", 0.25, 1)
	confSegment("holodeck/rapid3", 1)
	confSegment("holodeck/rapid4", 1)
	confSegment("holodeck/rapid5", 1)
	confSegment("holodeck/rapid6", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("holodeck/rapid_start", -l)	
	end
	
	local targetLen = 250 
	if mgGet("player.mode")=="0" then targetLen = 200 end
	if mgGet("player.mode")=="2" then targetLen = 320 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("holodeck/rapid_door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
