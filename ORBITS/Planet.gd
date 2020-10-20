extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



#var Gravid = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if !$Area2D/AreaShape == null:
		$Area2D/AreaShape.shape.radius=sqrt(mass*100000/0.1)


func _physics_process(delta):
	applied_force=PublicFuncs.Grav(position,mass,self)
	pass
