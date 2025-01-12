function init()

	mgFogColor(1.1, 1.3, 1.4, .2, .5, .7)
	mgMusic("moregames") 
	mgLowPass(0.2)
	mgReverb(0.2, 0.5, 0.2) 
	mgEcho(0.2, 0.3, 0.5, 0.4) 
	mgGravity(.4)
	
	l = 0
	while(l<10) do
		l = l + mgSegment("moregames_granny", -l)
		l = l + mgSegment("moregames_sprinkle", -l)
	end

	mgLength(l)
end

function tick()
end
