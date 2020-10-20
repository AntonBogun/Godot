extends Node

func newList():
	var list = [0]
	for i in 10:
		list+=list
	return list

#decrement by 1 unless ==0
func Delay(list,id):
	list[id]-=int(list[id]>0)

	pass
func _ready():
	pass # Replace with function body.
	
	
func Center(_Node,_pos):
	if _Node is Control:
		_Node.rect_position=_pos
	else:
		_Node.position=_pos
func Rotate(_Node,_angle):
	_Node.rotation = -_angle
func Rescale(_Node,_scale):
	
	if _Node is Control:
		_Node.rect_scale=_scale
	else:
		_Node.scale=_scale
func GlobalPos(obj):
	return obj.get_global_transform()[2]
#i want to never touch this idiocy ever again
func GetPos(_Node):
	if _Node is Control:
		return _Node.rect_position
	else:
		return _Node.position
#func bruh():
#	for Planet in get_tree().get_nodes_in_group("GravObj"):
#			print(Planet.Gravid)
#
#		#id != null and id != planet

func CustomRound(num,custom):
	return round(num*pow(10,custom))/pow(10,custom)

func Grav(Globalpos,mass,id=null):
	var Grav = Vector2()
	for Planet in get_tree().get_nodes_in_group("GravObj"):
		if (id!=Planet):
			var direct = Vector2(Planet.position[0],Planet.position[1])
			var directfull = direct + Vector2(-Globalpos[0],-Globalpos[1])
			var streng = Planet.mass/pow(directfull.length(),2)*100000*mass
			Grav += Vector2(directfull[0]/directfull.length()*streng,directfull[1]/directfull.length()*streng)
	return Grav
	

