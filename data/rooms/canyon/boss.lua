function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("boss_in")
	mgReverb(0.2, 0.8, 0.3)
	mgEcho(0.3, 0.2, 0.5, 0.5)
	mgFogColor(1.4, 1.25, 1, .5, 0, .4)

	l = 0
	l = l + mgSegment("canyon/boss/start", -l)	
	l = l + mgSegment("canyon/boss/mid", -l)	
	l = l + mgSegment("canyon/boss/end", -l)	
		
	mgLength(l)
end

function tick()
end
