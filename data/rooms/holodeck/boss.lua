function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("boss_in")
	mgReverb(0.2, 0.8, 0.3)
	mgEcho(0.3, 0.2, 0.5, 0.5)
	mgFogColor(1, 1.9, 2.2, .2, -.1, .3)
	mgGravity(.8)
	
	l = 0
	l = l + mgSegment("holodeck/boss/start", -l)	
	l = l + mgSegment("holodeck/boss/mid", -l)	
	l = l + mgSegment("holodeck/boss/end", -l)	
		
	mgLength(l)
end

function tick()
end
