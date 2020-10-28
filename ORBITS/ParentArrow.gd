extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var Delay
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_node("../../../..").parent!=null:
		visible=true
		var parent=get_node("../../../..").parent
		var lng=parent.global_position-PublicFuncs.ParentFind(RigidBody2D,self).global_position
		get_node("../ParentLabel").text="Dist to planet:\n"+PublicFuncs.FitNumber(lng.length()/10,11,2)
		rotation = atan2(lng.y,lng.x)+PI/2
		
		pass
	else:
		get_node("../ParentLabel").text="Dist to planet:\n0"
		visible=false
