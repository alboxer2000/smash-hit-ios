function init()
	pStart = mgGetBool("start", true)
	pEnd = mgGetBool("end", true)

	mgMusic("42_1") 
	mgReverb(0.7, 0.25, 0.6)
	mgLowPass(0.3)
	mgEcho(0.2, 0.15, 0.7, 0.85)
	mgFogColor(2, 1.7, .5, 0, -.3, .1)
	mgParticles("lowrising")
		
	confSegment("split/split1/16_0_coop", 1)
	confSegment("split/split1/16_1", 1)
	confSegment("split/split1/16_2_coop", 1)
	confSegment("split/split1/16_3", 1)
	confSegment("split/split1/16_4_coop", 1)
	confSegment("split/split1/16_5_coop", 1)
	confSegment("split/split1/16_6_coop", 1)
	confSegment("split/split1/16_laser_coop", 1)
	confSegment("split/split1/16_sweep_coop", 1)
	
	l = 0
	
	if pStart then
		l = l + mgSegment("split/split1/start", -l)	
	end
	
	while l < 60 do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end
	
	l = l + mgSegment("split/split1/16_0_coop", -l)	
	

	local targetLen = 140 
	targetLen = targetLen + mgGetSplitExtraRoomLength()
	while l < targetLen do
		s = nextSegment()
		l = l + mgSegment(s, -l)	
	end

	if pEnd then 
		l = l + mgSegment("split/split1/door", -l)	
	end
		
	mgLength(l)
end

function tick()
end
