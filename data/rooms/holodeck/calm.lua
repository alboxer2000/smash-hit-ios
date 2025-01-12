function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1, 1.9, 2.2, .2, -.1, .3)
	mgMusic("9")
	mgLowPass(0.1)
	mgReverb(0.2, 0.5, 0.2) 
	mgEcho(0.35, 0.3, 0.4, 0.5)

	confSegment("holodeck/calm0", 1)
	confSegment("holodeck/calm1", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("holodeck/calm_start", -l)	
	end
	
	local targetLen = 170 
	if mgGet("player.mode")=="0" then targetLen = 130 end
	if mgGet("player.mode")=="2" then targetLen = 170 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("holodeck/calm_door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
