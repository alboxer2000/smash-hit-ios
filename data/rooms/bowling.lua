function init()

	mgFogColor(.1, .1, .1, .9, .9, .8)
	mgMusic("moregames") 
	mgLowPass(0.2)
	mgReverb(0.2, 0.5, 0.2) 
	mgEcho(0.2, 0.3, 0.5, 0.4) 
	mgGravity(1.2)
	
	l = 0
	while(l<10) do
		l = l + mgSegment("bowlingbonus", -l)
	end

	mgLength(l)
end

function tick()
end
