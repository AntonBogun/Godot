extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var GravObj
#var GravArray = Array()
#var i = 0
var Delay
# Called when the node enters the scene tree for the first time.
func _ready():
	Delay=PublicFuncs.NewList()
	Delay[0]=60
	$SHIP.planet = $Planet # Replace with function body.
	#print($Planet)
	#for Planet in get_tree().get_nodes_in_group("GravObj"):
	#	GravArray.append(Planet)
	#print(PublicFuncs.HexToInt("3A"))
	pass
	



#DefaultGray = 25252A (Panel color)
#CodeDarkBlue = 202531 (code window color)
#NavBallOutside = 0E0B54 (random lol)
#proper way to do toggle of UI is in $Controls
