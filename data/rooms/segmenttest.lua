function init()
	mgFogColor(.1, .4, 0);
	mgMusic("silent") 
	
	z = 0
	for i=0, 2 do
		l = mgSegment("#SEGMENT#", z)
		z = z - l
	end
	mgLength(-z)
end


