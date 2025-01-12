function init()
	pLength = 120

	local r = math.random(5)
	
    if r == 1 then
		mgFogColor(1.5, 1.7, 1.4, 0, -2.5, -.2)
		mgMusic("39")
    elseif r == 2 then
		mgFogColor(-.3, 0, .1, 1.1, 1.5, 1.1)
		mgMusic("6")
    elseif r == 3 then
		mgFogColor(1.7, 1.4, 1.1, -.3, -.8, -.1)
		mgMusic("30")
    elseif r == 4 then
		mgFogColor(-.3, .1, .3, 1.2, 1.3, 1.1)
		mgMusic("28")
	elseif r == 5 then
 		mgFogColor(1.4, 1.3, 1.1, -.2, .1, .1)
		mgMusic("5")
	end	
	
	mgLowPass(0.2)
	mgReverb(.1, 0.9, 0.1) 
	mgEcho(0.4, 0.3, 0.7, 0.9)
	mgParticles("lowrising")
	mgGravity(.4)
	
	confSegment("zen/open/fillers/8_0", .5)
	confSegment("zen/open/fillers/8_1", .5)
	confSegment("zen/open/fillers/8_2", .1)
	confSegment("zen/open/fillers/8_3", .1)
	confSegment("zen/open/fillers/16_0", .5)
	confSegment("zen/open/fillers/16_1", .1)

	confSegment("zen/open/obstacles/8_foldwindow", 1)
	confSegment("zen/open/obstacles/8_foldwindow2", 1)
	confSegment("zen/open/obstacles/8_rotor", 1)
	confSegment("zen/open/obstacles/8_rotor2", 1)
	confSegment("zen/open/obstacles/8_suspendbox", 1)
	confSegment("zen/open/obstacles/8_suspendwindow", 1)
	confSegment("zen/open/obstacles/16_sweepers", 1)
	confSegment("zen/open/obstacles/16_sweepers_x2", 1)
	
	confSegment("zen/open/scores/8_scoretops_x2", .5)
	confSegment("zen/open/scores/16_scoretops_x4", .5)
	confSegment("zen/open/scores/16_scoretops_x4_2", .5)
	confSegment("zen/open/scores/16_scoretops_x6", .5)
	confSegment("zen/open/scores/16_scoretops_x8", .5)
	confSegment("zen/open/scores/16_scoretops_x6", .5)
	
	confSegment("zen/open/powerups/8_ballfrenzy", .25)
	confSegment("zen/open/powerups/8_ballfrenzy2", .25)
	confSegment("zen/open/powerups/8_slomo", .25)
	
	l = 0
	l = l + mgSegment("zen/open/start", -l)	
	
	while l < pLength do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	l = l + mgSegment("zen/open/door", -l)
	
	mgLength(l)
end

function tick()
end
