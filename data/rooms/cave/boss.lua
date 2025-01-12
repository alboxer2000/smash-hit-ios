function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("boss_in")
	mgReverb(0.2, 0.8, 0.3)
	mgEcho(0.3, 0.2, 0.5, 0.5)
	mgFogColor(0, -.2, .4, 1.2, 1.3, .9)

	l = 0
	l = l + mgSegment("cave/boss/start", -l)	
	l = l + mgSegment("cave/boss/mid", -l)	
	l = l + mgSegment("cave/boss/end", -l)	
		
	mgLength(l)
end

function tick()
end
