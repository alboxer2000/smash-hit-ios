function init()
	w = mgGetFloat("width", 2)
	h = mgGetFloat("height", 2)
	buttons = mgGetInt("buttons", 0)
	distance = mgGetFloat("distance", 5)

	mgMaterial("door")
	mgColor(1,1,1)
	mgShapeChamfer(0.03)
	mgRoundness(0.2)
	
	left = mgCreateBody()
	mgCreateBox(left, w/4, h/2, 0.1, -w/4, h/2, 0)

	right = mgCreateBody()
	mgCreateBox(right, w/4, h/2, 0.1, w/4, h/2, 0)
	
	if buttons == 1 then
		b, x, y, z = mgRaycast(0, h+0.5, 3, 0, h+0.5, -3)
		b0 = mgCreateButton(x, y, z)
	end
	if buttons == 2 then
		b, x, y, z = mgRaycast(-w/2-0.5, h/2, 3, -w/2-0.5, h/2, -3)
		b0 = mgCreateButton(x, y, z)
		b, x, y, z = mgRaycast(w/2+0.5, h/2, 3, w/2+0.5, h/2, -3)
		b1 = mgCreateButton(x, y, z)
	end
	snd = mgCreateSound("snd/door/1.ogg")
end

function tick()
	if buttons == 0 then
		open = mgCameraDistance() < distance
	end
	if buttons == 1 then
		open = mgIsButtonDown(b0)
	end
	if buttons == 2 then
		open = mgIsButtonDown(b0) and mgIsButtonDown(b1)
	end
	if open then openFrame = openFrame + 1 else openFrame = 0 end
	if openFrame == 1 then
		mgPlaySound(snd)
		mgDoorOpened()
	end
	if openFrame>0 then
		mgMove(left, -w/2+0.05, 0, 0, 100, 0.8)
		mgMove(right, w/2-0.05, 0, 0, 100, 0.8)
	else
		mgMove(left, 0.021, 0, 0)
		mgMove(right, -0.021, 0, 0)
	end
end

