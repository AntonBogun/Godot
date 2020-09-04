extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func bruh():
	for Planet in get_tree().get_nodes_in_group("GravObj"):
			print(Planet.Gravid)
		
		#id != null and id != planet
func Grav(Globalpos,mass,id=null):
	var Grav = Vector2()
	for Planet in get_tree().get_nodes_in_group("GravObj"):
		if (id!=Planet):
			var direct = Vector2(Planet.position[0],Planet.position[1])
			var directfull = direct + Vector2(-Globalpos[0],-Globalpos[1])
			var streng = Planet.mass/pow(directfull.length(),2)*100000*mass
			Grav += Vector2(directfull[0]/directfull.length()*streng,directfull[1]/directfull.length()*streng)
	return Grav
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
