function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("boss_in")
	mgReverb(0.2, 0.8, 0.3)
	mgEcho(0.3, 0.2, 0.5, 0.5)
	mgFogColor(1.55, 1.1, 1.1, 0, .25, .2)

	l = 0
	l = l + mgSegment("river/boss/start", -l)	
	l = l + mgSegment("river/boss/mid", -l)	
	l = l + mgSegment("river/boss/end", -l)	
		
	mgLength(l)
end

function tick()
end
