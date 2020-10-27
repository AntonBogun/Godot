extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Delay
#var Gravid = 0
var resetarray=Array()
var gravdescribe = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Delay = PublicFuncs.NewList()
	
	if !$Area2D/AreaShape == null:
		$Area2D/AreaShape.shape.radius=sqrt(mass*100000/0.1)
	

func _physics_process(delta):
	
	if Delay[0]==0:
		Delay[0]=60
		gravdescribe=true
	Delay[0]=PublicFuncs.Delay(Delay[0])

	resetarray=PublicFuncs.ApplyGrav(mass,global_position,$Area2D,self,resetarray,gravdescribe)
	gravdescribe=false
	#applied_force=PublicFuncs.Grav(position,mass,self)
	pass
