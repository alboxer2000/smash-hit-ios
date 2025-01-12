function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1, 1.9, 2.2, .2, -.1, .3)
	mgMusic("15")
	mgLowPass(0.1)
	mgReverb(0.2, 0.5, 0.2) 
	mgEcho(0.35, 0.3, 0.4, 0.5)

	confSegment("holodeck/bs", 1)
	confSegment("holodeck/bs2", 1)
	confSegment("holodeck/bs3", 1)
	confSegment("holodeck/fold", 1)
	confSegment("holodeck/fold2", 1)
	confSegment("holodeck/fold3", 0.5)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("holodeck/start0", -l)	
	end
	
	local targetLen = 160 
	if mgGet("player.mode")=="0" then targetLen = 120 end
	if mgGet("player.mode")=="2" then targetLen = 200 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("holodeck/beat_door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
