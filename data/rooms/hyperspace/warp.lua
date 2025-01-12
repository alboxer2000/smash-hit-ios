function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1, 1.3, 2, .1, 0, 0)
	mgMusic("34")
	mgReverb(.2, 0.4, 0.3) 
	mgEcho(0.3, 0.3, 0.4, 0.3)
	mgGravity(0)
	mgSetRotation(2, 2.0)
	mgParticles("starfield")
	mgParticles("starfield")
	
	confSegment("hyperspace/warp/32_0", 1)
	confSegment("hyperspace/warp/32_1", 1)
	confSegment("hyperspace/warp/32_2", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("hyperspace/warp/start", -l)	
	end

	while l < 200 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	l = l + mgSegment("hyperspace/warp/32_3", -l)

	local targetLen = 450 
	if mgGet("player.mode")=="0" then targetLen = 300 end
	if mgGet("player.mode")=="2" then targetLen = 500 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("hyperspace/warp/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
