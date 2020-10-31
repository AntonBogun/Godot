extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Delay
#var Gravid = 0
export var color = Color(0.5,0.5,0.5)
export var masss : float=10000
export var disabled=false
var resetarray=Array()
export var gravdescribe = false
export var gravlim = 1
export var size=1300
var gravradius =50000
# Called when the node enters the scene tree for the first time.
func _ready():
	
	gravradius =sqrt(masss*100000/gravlim)
	
	if disabled:
		visible =false
		remove_from_group("GravObj")
		remove_from_group("SimObj")
		$CollisionShape2D.disabled=true
		queue_free()
	$CollisionShape2D.shape=$CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.radius=size
	mass=masss
	Delay = PublicFuncs.NewList()
	
	if !$Area2D/AreaShape == null:
		$Area2D/AreaShape.shape.radius=gravradius
	

func _physics_process(delta):
	if Delay[0]==0:
		Delay[0]=60
		gravdescribe=true
	Delay[0]=PublicFuncs.Delay(Delay[0])

	resetarray=PublicFuncs.ApplyGrav(mass,global_position,$Area2D,self,resetarray,gravdescribe)
	gravdescribe=false
	#applied_force=PublicFuncs.Grav(position,mass,self)
	pass
