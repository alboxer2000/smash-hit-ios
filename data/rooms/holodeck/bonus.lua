function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(.6, 1.5, 1.8, 0, -.3, .1)
	mgMusic("6")
	mgLowPass(0.1)
	mgReverb(0.3, 0.8, 0.1) 
	mgEcho(0.35, 0.3, 0.4, 0.5)
	mgParticles("falling")

	confSegment("holodeck/bonus_16_0", 1)
	confSegment("holodeck/bonus_16_1", 1)
	confSegment("holodeck/bonus_16_2", 1)
	confSegment("holodeck/bonus_16_3", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("holodeck/bonus_start", -l)	
	end
	
	while l < 90 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("holodeck/bonus_door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
