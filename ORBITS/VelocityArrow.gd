extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_node("../../../..").parent!=null:
		visible=true
		var vel = get_node("../../../..").parent.linear_velocity-PublicFuncs.ParentFind(RigidBody2D,self).linear_velocity
		rotation = atan2(vel.y,vel.x)-PI/2
		if vel.length()<5:
			visible=false
		get_node("../VelocityLabel").text="Velocity:\n"+PublicFuncs.FitNumber(vel.length(),9,2)
		if PublicFuncs.FitNumber(vel.length(),9,2).length()>6:
			print(vel.length())
	else:
		visible=false
