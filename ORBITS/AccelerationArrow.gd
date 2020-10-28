extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var relative=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_node("../../../..").parent!=null:
		visible=true
		var acc = int(relative)*get_node("../../../..").parent.applied_force-(int(relative)*2-1)*PublicFuncs.ParentFind(RigidBody2D,self).applied_force
		rotation = atan2(acc.y,acc.x)+PI/2
		if acc.length()>0.1:
			get_node("../AccelerationLabel").text="Acceleration:\n"+PublicFuncs.FitNumber(acc.length()/10,11,2)
		else:
			get_node("../AccelerationLabel").text="Acceleration:\n0"
			visible=false
		pass
	else:
		get_node("../AccelerationLabel").text="Acceleration:\n0"
		visible=false
