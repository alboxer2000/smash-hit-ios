function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("boss_in")
	mgReverb(0.2, 0.8, 0.3)
	mgEcho(0.3, 0.2, 0.5, 0.5)
	mgFogColor(.7, 1.5, 1.5, 0, -.3, .1)
	mgGravity(.4)
	
	l = 0
	l = l + mgSegment("ocean/boss/start", -l)	
	l = l + mgSegment("ocean/boss/mid", -l)	
	l = l + mgSegment("ocean/boss/end", -l)	
		
	mgLength(l)
end

function tick()
end
