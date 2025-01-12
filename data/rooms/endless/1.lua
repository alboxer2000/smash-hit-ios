function init()
	pEndless = mgGetInt("endless", 0)

	mgFogColor(1.4, 1.25, 1, .5, 0, .4)
	mgMusic("18")
	mgLowPass(0.2)
	mgReverb(.6, 0.1, 0.3) 
	mgEcho(0.4, 0.04, 0.7, 0.9)

	local p = 1.0 - pEndless*0.2
	if p < 0 then p = 0 end

	local difficulty = pEndless*0.2
	if difficulty > 1 then difficulty = 1 end
	mgSetDifficulty(difficulty)
	
	confSegment("endless/fillers/8_0", 1)
	confSegment("endless/fillers/8_1", 1)
	confSegment("endless/fillers/8_2", 1)
	confSegment("endless/fillers/8_3", 1)
	confSegment("endless/fillers/16_0", 1)
	confSegment("endless/fillers/16_1", 1)
	confSegment("endless/obstacles/16_sweepers_x2", 1)
	confSegment("endless/obstacles/16_pendulums_x2", 1)
	confSegment("endless/obstacles/16_lasers_x2", 1)
	confSegment("endless/obstacles/16_flycubes_x2", 1)
	confSegment("endless/obstacles/16_dropblocks", 1)
	confSegment("endless/obstacles/16_cranks_x2", 1)
	confSegment("endless/obstacles/8_suspendwindow", 1)
	confSegment("endless/obstacles/8_suspendside", 1)
	confSegment("endless/obstacles/8_suspendcube", 1)
	confSegment("endless/obstacles/8_suspendbox", 1)
	confSegment("endless/obstacles/8_rotor", 1)
	confSegment("endless/obstacles/8_rotor2", 1)
	confSegment("endless/obstacles/8_revolver", 1)
	confSegment("endless/obstacles/8_revolver2", 1)
	confSegment("endless/obstacles/8_pyramid", 1)
	confSegment("endless/obstacles/8_laser", 1)
	confSegment("endless/obstacles/8_foldwindow", 1)
	confSegment("endless/obstacles/8_foldwindow2", 1)
	confSegment("endless/obstacles/8_beatmill", 1)
	confSegment("endless/scores/16_scoretops_x8", 1)
	confSegment("endless/scores/16_scoretops_x6", 1)
	confSegment("endless/scores/16_scoretops_x4", 1)
	confSegment("endless/scores/16_scoretops_x4_2", 1)
	confSegment("endless/scores/8_scoretops_x2", 1)
	confSegment("endless/scores/8_scoretop", 1)
	confSegment("endless/scores/8_scoretop2", 1)
	confSegment("endless/scores/8_scoretop3", 1)
	confSegment("endless/scores/8_scoretop4", 1)
	confSegment("endless/powerups/8_ballfrenzy", 1)
	confSegment("endless/powerups/8_ballfrenzy2", 1)
	confSegment("endless/powerups/8_nitroballs", 1)
	confSegment("endless/powerups/8_nitroballs2", 1)
	confSegment("endless/powerups/8_slomo", 1)
	confSegment("endless/powerups/8_slomo2", 1)
	
	l = 0
	
	if pEndless == 1 then
		l = l + mgSegment("endless/obstacles/8_beatmill", -l)	
	end
	
	local len = pEndless*50 + 150
	if len > 400 then len = 400 end
	
	while l < len do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	mgLength(l)
end

function tick()
end
