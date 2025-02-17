function init()
	w = mgGetFloat("size", 2)
	h = mgGetFloat("size", 2)
	buttons = mgGetInt("buttons", 0)

	mgMaterial("door")
	mgColor(1,1,1)
	mgShapeChamfer(0.04)
	mgRoundness(0.1)
	
	left = mgCreateBody()
	mgCreateBox(left, w/2, h/2, 0.05, -w/2*1.414, h/2, 0, 0, 0, math.pi/4)

	right = mgCreateBody()
	mgCreateBox(right, w/2, h/2, 0.05, w/2*1.414, h/2, 0, 0, 0, math.pi/4)

	top = mgCreateBody()
	mgCreateBox(top, w/2, h/2, 0.05, 0, h/2+h/2*1.414, 0, 0, 0, math.pi/4)

	bottom = mgCreateBody()
	mgCreateBox(bottom, w/2, h/2, 0.05, 0, h/2-h/2*1.414, 0, 0, 0, math.pi/4)
	
	if buttons == 1 then
		b, x, y, z = mgRaycast(0, h+0.5, 3, 0, h+0.5, -3)
		b0 = mgCreateButton(x, y, z+0.05)
	end
	if buttons == 2 then
		b, x, y, z = mgRaycast(-w/2-0.5, h/2, 3, -w/2-0.5, h/2, -3)
		b0 = mgCreateButton(x, y, z+0.05)
		b, x, y, z = mgRaycast(w/2+0.5, h/2, 3, w/2+0.5, h/2, -3)
		b1 = mgCreateButton(x, y, z+0.05)
	end
	
	snd = mgCreateSound("snd/door/1.ogg")
end

function tick()
	if buttons == 0 then
		open = mgCameraDistance() < 5
	end
	if buttons == 1 then
		open = mgIsButtonDown(b0)
	end
	if buttons == 2 then
		open = mgIsButtonDown(b0) and mgIsButtonDown(b1)
	end
	if open then
		openFrame = openFrame + 1
	else
		openFrame = 0
	end
	if openFrame == 1 then
		mgPlaySound(snd)
		mgDoorOpened()
	end
	if openFrame > 0 then
		mgMove(top, 0, h/2-0.1, 0, 100, 0.8)
		mgMove(bottom, 0, -h/2+0.1, 0, 100, 0.8)
		mgMove(left, -w/2+0.1, 0, 0, 100, 0.8)
		mgMove(right, w/2-0.1, 0, 0, 100, 0.8)
	else
		mgMove(left, 0.05, 0, 0)
		mgMove(right, -0.05, 0, 0)
		mgMove(top, 0, -0.05, 0)
		mgMove(bottom, 0, 0.05, 0)
	end
end

