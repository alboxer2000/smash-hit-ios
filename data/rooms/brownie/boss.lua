function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("boss_in")
	mgReverb(0.2, 0.8, 0.3)
	mgEcho(0.3, 0.2, 0.5, 0.5)
	mgFogColor(1, 1.2, 1.4, .4, -.3, -.5)

	l = 0
	l = l + mgSegment("brownie/boss/start", -l)	
	l = l + mgSegment("brownie/boss/mid", -l)	
	l = l + mgSegment("brownie/boss/end", -l)	
		
	mgLength(l)
end

function tick()
end
