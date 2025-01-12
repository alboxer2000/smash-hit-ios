function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgFogColor(1.25, .85, .5, -.7, -.1, .2)
	mgMusic("25")
	mgReverb(.3, 0.6, 0.2) 
	mgEcho(0.3, 0.4, 0.7, 0.1)
	mgParticles("lowrising")
	
	confSegment("night/part2/crank", 1)
	confSegment("night/part2/crank2", 1)
	confSegment("night/part2/dna_dec", 1)
	confSegment("night/part2/dna_dec2", 1)
	confSegment("night/part2/dna_st", 1)
	confSegment("night/part2/dna_st2", 1)
	confSegment("night/part2/dna_st3", 1)
	confSegment("night/part2/bar", 1)
	confSegment("night/part2/iris", 1, 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("night/part2/start", -l)	
	end

	local targetLen = 140 
	if mgGet("player.mode")=="0" then targetLen = 120 end
	if mgGet("player.mode")=="2" then targetLen = 180 end
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("night/part2/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
