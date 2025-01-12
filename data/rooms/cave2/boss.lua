function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("boss_in")
	mgReverb(0.2, 0.8, 0.3)
	mgEcho(0.3, 0.2, 0.5, 0.5)
	mgFogColor(.4, 0, .5, 1.3, .9, .6)

	l = 0
	l = l + mgSegment("cave2/boss/start", -l)	
	l = l + mgSegment("cave2/boss/mid", -l)	
	l = l + mgSegment("cave2/boss/end", -l)	
		
	mgLength(l)
end

function tick()
end
