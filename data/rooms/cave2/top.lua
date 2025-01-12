function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)
	pDifferent = mgGetBool("different", false)

	if pDifferent then
		mgMusic("10")
		mgFogColor(1.3, .7, .6, .5, 0, .5)
		mgParticles("lowrising")
	else
		mgMusic("30")
		mgFogColor(.4, 0, .5, 1.3, .9, .6)
	end

	mgReverb(.3, 0.8, 0.2) 
	mgEcho(0.2, 0.8, 0.3, 0.8)
	mgLowPass(0.3)

	confSegment("cave2/top/16_0", 1,2)
	confSegment("cave2/top/16_1", 1,3)
	confSegment("cave2/top/16_2", 1)
	confSegment("cave2/top/16_3", 1)
	confSegment("cave2/top/16_4", 1)
	confSegment("cave2/top/16_5", 1,2)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("cave2/top/start", -l)	
	end
	
	len = 250
	if pDifferent then len = 140 end
	if mgGet("player.mode")=="0" then len = len * 0.8 end
	if mgGet("player.mode")=="2" then len = len * 1.1 end
	
	while l < len do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	if pEnd then 
		if pDifferent then
			l = l + mgSegment("cave2/top/door2", -l)
		else 
			l = l + mgSegment("cave2/top/door", -l)
		end
	end
		
	mgLength(l)
end

function tick()
end
