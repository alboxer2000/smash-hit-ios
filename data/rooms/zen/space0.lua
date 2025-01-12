function init()
	pLength = 170

	local r = math.random(5)
	
    if r == 1 then
		mgFogColor(0, 0, -.3, 0, .9, 1.2)
		mgMusic("8")
		mgSetRotation(1)
    elseif r == 2 then
		mgFogColor(1.1, 1.4, .8, -.7, -.6, .1)
		mgMusic("24")
		mgSetRotation(2)
    elseif r == 3 then
		mgFogColor(1.7, 1.4, 1.1, -.3, -.1, -.8)
		mgMusic("2")
		mgSetRotation(-2)
	elseif r == 4 then
		mgFogColor(-.8, -.1, .3, 1, 1.3, 1)
		mgMusic("25")
	elseif r == 5 then
		mgSetRotation(-1)
 		mgFogColor(-.2, .1, .1, 1.4, 1.3, 1.1)
		mgMusic("22")
	end	

	mgLowPass(0.2)
	mgReverb(.6, 0.1, 0.3) 
	mgEcho(0.6, 0.5, 0.6, 0.2)
	mgParticles("starfield")
	mgGravity(0)
	
	confSegment("zen/space/obstacles/16_0", 1)
	confSegment("zen/space/obstacles/16_1", 1)
	confSegment("zen/space/obstacles/16_2", 1)
	confSegment("zen/space/obstacles/16_3", 1)
	
	confSegment("zen/space/scores/16_0", 0.5)
	confSegment("zen/space/scores/16_1", 0.5)
	confSegment("zen/space/scores/16_2", 0.5)
	confSegment("zen/space/scores/16_3", 0.5)

	l = 0
	l = l + mgSegment("zen/space/start", -l)	
	
	while l < pLength do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	l = l + mgSegment("zen/space/door", -l)
	
	mgLength(l)
end

function tick()
end
