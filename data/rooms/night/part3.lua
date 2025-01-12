function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.6, 1.4, 2, -.8, 0, 0)
	mgMusic("20")
	mgReverb(.2, 0.7, 0.1) 
	mgEcho(0.3, 0.5, 0.2, 0.1)
	mgParticles("lowrising2")

	confSegment("night/part3/elgrid_line_st", 0.4)
	confSegment("night/part3/elgrid_line_st2", 0.4)
	confSegment("night/part3/pendulums", 2)
	confSegment("night/part3/suspendcube", 1)
	confSegment("night/part3/suspendcubes", 1)
	confSegment("night/part3/suspendcubes_2", 1)
	confSegment("night/part3/suspendcubes_3", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("night/part3/start", -l)	
	end

	local targetLen = 190 
	if mgGet("player.mode")=="0" then targetLen = 140 end
	if mgGet("player.mode")=="2" then targetLen = 260 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("night/part3/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
