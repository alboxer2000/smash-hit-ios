function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("11") 
	mgReverb(0.7, 0.25, 0.6)
	mgLowPass(0.3)
	mgEcho(0.2, 0.15, 0.7, 0.85)
	mgFogColor(1.7, 1.2, 1.2, 0, .4, .5)

	confSegment("basic/darker/bs", 1)
	confSegment("basic/darker/2_bs_arch", 1)
	confSegment("basic/darker/chasms", 1)
	confSegment("basic/darker/chasms_bs", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("basic/darker/start", -l)	
	end
	
	while l < 60 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	
	l = l + mgSegment("basic/darker/powerup", -l)	
	

	local targetLen = 120 
	if mgGet("player.mode")=="0" then targetLen = 100 end
	if mgGet("player.mode")=="2" then targetLen = 150 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("basic/darker/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
