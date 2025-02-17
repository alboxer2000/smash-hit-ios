function init()
	mgMaterial("glass")
	mgColor(1,1,1)
	mgDensity(0.7)
	b = mgCreateBody(0, 0, 0)

	local xc = 2
	local yc = 2
	local zc = 2

	local l = 2
	local t = 0.1

	mgCreateBox(b, t/2,t/2,t/2)

	for z=1,zc+1 do
		for y=1,yc+1 do
			for x=1,xc do
				mgCreateBox(b, l/2-t/2, t/2, t/2, (x-xc/2-0.5)*l, (y-yc/2-1)*l, (z-zc/2-1)*l)
			end
		end
	end
	for z=1,zc+1 do
		for x=0,xc do
			for y=1,yc do
				mgCreateBox(b, t/2, l/2-t/2, t/2, (x-xc/2)*l, (y-yc/2-0.5)*l, (z-zc/2-1)*l)
			end
		end
	end
	for x=0,xc do
		for y=0,yc do
			for z=1,zc do
				mgCreateBox(b, t/2, t/2, l/2+t/2, (x-xc/2)*l, (y-yc/2)*l, (z-zc/2-0.5)*l)
			end
		end
	end
	mgSetAngVel(b, 0.2, 0.1, -0.2)
end

function tick()
	local t=mgCameraDistance()
	local x=math.sin(t*0.5)
	local y=math.sin(t*1.2)
	mgMove(b, 0, 0, 0)
end



