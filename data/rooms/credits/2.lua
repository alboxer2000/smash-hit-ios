function init()
	pLast = mgGetBool("last", false)

	if pLast then
		mgMusic("silent")
	else
		mgMusic("bowling")
	end
	mgReverb(0.2, 0.8, 0.3)
	mgEcho(0.3, 0.2, 0.5, 0.5)
	mgFogColor(.1, .1, .1, .9, .9, .8)
	mgGravity(1.0)	
	
	l = 0
	
	l = l + mgSegment("credits/bowling", -l)	
	l = l + mgSegment("credits/bowling", -l)	
		
	mgLength(l)
end

function tick()
end
