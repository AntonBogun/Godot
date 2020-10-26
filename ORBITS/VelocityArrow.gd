extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var vel = PublicFuncs.ParentFind(RigidBody2D,self).linear_velocity
	rotation = atan2(vel.y,vel.x)+PI/2
	
	pass
