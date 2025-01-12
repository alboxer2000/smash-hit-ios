
function init()
	x = mgGetFloat("x", 0)
	y = mgGetFloat("y", 0)
	z = mgGetFloat("z", -15)
	rx = mgGetFloat("rx", 0)
	ry = mgGetFloat("ry", 0)
	rz = mgGetFloat("rz", 0)
	length = mgGetFloat("length", 40)
	width = mgGetFloat("width", 7)
	height = mgGetFloat("height", 4)
	door = mgGetBool("door", false)

	mgLength(length)
	mgMusic(mgGetString("music", "silent"))

	l = 0
	l = l + mgSegment("empty", -l)
	l = l + mgSegment("empty", -l)
	l = l + mgSegment("empty", -l)

	mgLength(l)
	mgColor(1,1,1)

	mgObstacle("#OBSTACLE#", x, y, z, rx, ry, rz)
end

