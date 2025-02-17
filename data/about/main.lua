sceneLength = {}
sceneStart = {}
sceneFunc = {}
sceneCalled = {}

--Tweak time offset
timeOffset = 0

function init()

	-- Add all scenes here
	addScene(sceneFirst, 5.0)
	addScene(sceneEnd, 5.0)

	canvas = mgCreateCanvas(1024, 768)
	canvas2 = mgCreateCanvas(1024, 768)
	canvas3 = mgCreateCanvas(1024, 768)
	canvas4 = mgCreateCanvas(1024, 768)
	canvas5 = mgCreateCanvas(1024, 768)
	
	local current = 0.0
	for i=1, #sceneLength do
		sceneStart[i] = current
		current = current + sceneLength[i]
	end	
end


function addScene(func, length)
	sceneFunc[#sceneFunc+1] = func
	sceneLength[#sceneLength+1] = length
	sceneCalled[#sceneLength+1] = false
end


function getScene(time)
	local t = time + timeOffset
	scene = 0
	sceneTime = 0.0
	for i=1, #sceneStart do
		if (t > sceneStart[i]) then
			scene = i
			sceneTime = t-sceneStart[i]
		end
	end
	return scene, sceneTime
end


function frame()
end


function draw()
	time = mgScriptTime()
	local scene = 0
	local t = 0.0
	scene, t = getScene(time)
	sceneFunc[scene](t, not sceneCalled[scene])
	sceneCalled[scene] = true
end


----------------- SCENES -----------------


function sceneFirst(t, first)
	if first then
		mgSetScale(canvas, 1, 1)
	end
	
	mgPushCanvas(canvas)

	--DO STUFF HERE
	
	mgPopCanvas()
end


function sceneEnd(t, first)
	if first then
		mgCommand("game.menu")
	end
end

