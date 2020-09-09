extends ParallaxLayer

# NEED TO ADD UN-STACK ALGORITHM


var paralx = get_parent()
var zoom
var Delay=PublicFuncs.newList()
var size
var size2
var checkarray=Array()
var sectors = Array()
# Called when the node enters the scene tree for the first time.
func _ready():
	size = get_parent().get_parent().get_node("Actual View").polygon
	var temp = 2
	for point in size:
		point = point*1.25
	size2= Vector2(size[1][0]-size[2][0],size[0][1]-size[1][1])
	for y in 5:
		for x in 10:
			 checkarray.append(Vector2(size2[0]/10*(x-1)+size[2][0],size2[0]/5*(y-1)+size[2][1]))
	pass # Replace with function body.
func sectorsetup(coords):
	var sed = int(str(coords[0])+str(coords[1]))
	var instance= $Sector.duplicate()
	instance.rngseed=sed
	instance.position = coords*1000
	instance.visible = true
	instance.online = true
	sectors.append(instance,coords)
func UpdateSectors():
	for point in size:
		var minlen = Vector2(1000,1000)
		for sector in sectors:
			pass
		if minlen[0]>500 or minlen[1]>500:
			var coords = Vector2(round((point[0]+paralx[0])/500),round((point[1]+paralx[1])/500))
			sectorsetup(coords)
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	zoom= get_parent().get_parent().zoom[0]
	print(get_parent().scroll_offset*-0.05)
#	paralx = get_parent().scroll_offset*0.05
	PublicFuncs.Delay(Delay,0)
	
	if(Delay[0]==0):
		Delay[0]=20
