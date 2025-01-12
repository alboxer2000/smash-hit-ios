function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1, 1.9, 2.2, .2, -.1, .3)
	mgMusic("6")
	mgReverb(0.05, 0.8, 0.1) 
	mgEcho(0.35, 0.5, 0.4, 0.2)

	confSegment("holodeck/bonus", 1)
	
	l = 0
	l = l + mgSegment("holodeck/bonus", -l)	
	l = l + mgSegment("holodeck/bonus_door", -l)	
		
	mgLength(l)
end

function tick()
end
