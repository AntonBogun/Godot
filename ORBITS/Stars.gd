extends Node2D

# NEED TO ADD UN-STACK ALGORITHM


var paralx
var Delay=PublicFuncs.newList()
var size
var size2
var checkarray=Array()
var sectors = Array()
var debugstr = ""

var Camer 
var viewsize
var Target
# Called when the node enters the scene tree for the first time.\




func _ready():
	Camer = get_node("../../../SHIP/Camera2D")
	viewsize = get_node("../../../SHIP/ActualView")
	Target = get_node("../../../SHIP")
	size = viewsize.polygon
	for point in size:
		point = point*1.25
	size2= Vector2(size[1][0]-size[2][0],size[0][1]-size[1][1])
	for y in 5:
		for x in 10:
			 checkarray.append(Vector2(size2[0]/10*(x-1)+size[2][0],size2[0]/5*(y-1)+size[2][1]))
			
	pass # Replace with function body.
#	var test = [0,1,2,3,4,5]
#	for i in test.size():
#		var n =test.size()-i-1
#		if test[n]==3 or test[n]==1:
#			test.remove(n)
#	print(test)
#	print(range(10))




func sectorsetup(coords):
	var sed = int(str(coords[0])+str(coords[1]))
	var instance= $Sector.duplicate()
	call_deferred("add_child", instance)
	instance.rngseed=sed
	instance.position = coords*1000
	instance.visible = true
	instance.online = true
	instance.displace = Vector2(0,0)
	instance.minlen=0
	sectors.append(instance)
#	debugstr +="apennded"+str(instance.position) + "\n"
func UpdateSectors():
	for campoint in checkarray:
		var point = campoint+paralx
		var minlen = 1000
		var dist = Vector2(1000,1000)
		for sector in sectors:
			var distx =abs(sector.position.x-point.x)
			var disty = abs(sector.position.y-point.y)
			var distxy = Vector2(distx,disty)
			if distxy.length()<minlen:
				minlen = distxy.length()
				dist = distxy
			var sectorx=abs(sector.position.x-point.x)
			var sectory=abs(sector.position.y-point.y)
			if Vector2(sectorx,sectory).length()<sector.minlen:
				sector.minlen = Vector2(sectorx,sectory).length()
				sector.displace = Vector2(sectorx,sectory)
			
			
#		debugstr +=str(dist)+"minlen, point = "+str(point)+"\n\n"
		if dist[0]>500 or dist[1]>500:
			var coords = Vector2(round(point[0]/1000),round(point[1]/1000))
#			debugstr +=str(coords)+"coords\n"
			sectorsetup(coords)
	var n =sectors.size()-1
	for sector in sectors.size():
		if sectors[n].displace[0]>500 or sectors[n].displace[1]>500:
			sectors[n].cull=true
			sectors.remove(n)
		else:
			sectors[n].displace=Vector2(1000,1000)
			sectors[n].minlen = 1000
		n-=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	PublicFuncs.Delay(Delay,0)
#	position=Target.position*0.05
	
	paralx = Target.position*0.05
	if(Delay[0]==0):
		
		UpdateSectors()
#		print(debugstr)
		Delay[0]=20


