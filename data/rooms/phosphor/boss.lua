function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("boss_in")
	mgReverb(0.2, 0.8, 0.3)
	mgEcho(0.3, 0.2, 0.5, 0.5)
	mgFogColor(1.4, 1.5, 1.2, -.4, .3, .3)

	l = 0
	l = l + mgSegment("phosphor/boss/start", -l)	
	l = l + mgSegment("phosphor/boss/mid", -l)	
	l = l + mgSegment("phosphor/boss/end", -l)	
		
	mgLength(l)
end

function tick()
end
