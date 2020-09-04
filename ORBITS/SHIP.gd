extends RigidBody2D
var planet



var thrust = Vector2(0, -750)
var torque = 10000


var Exhaust = Array()
var Ereload = 0
var Ecount = 0
var pressed = 1
var groundmult =1
var torquetimer=0
var relative
var Planethost




func Closest():
	relative = null
	for _Planet in get_tree().get_nodes_in_group("GravObj"):
			var prerelative = Vector2(_Planet.position-position).length()
			if(relative!=null):
				if(prerelative<relative):
					relative = prerelative
					Planethost=_Planet
			else:
				relative = prerelative
				Planethost=_Planet







func _ready():
	planet = get_node("../Planet")
	Closest()

#EXTEND

#var step=1
#func _draw():
##	for bodies in SimObj:
##
#	for i in range(step):
#		draw_line(Vector2(0,-(i-1)*10),Vector2(0,-i*10),Color(255,0,0),i)






func _physics_process(delta):
#	step+=1
#	update()
	# thrust and turning
	
	applied_force = Vector2()
	if Input.is_action_pressed("ui_up"):
		applied_force += thrust.rotated(rotation)
		if (Ereload == 0):
			if Ecount<100:
				Exhaust.append(null)
			Exhaust[Ecount]=$Exhaust.duplicate()
			call_deferred("add_child", Exhaust[Ecount])
			Exhaust[Ecount].online = true
			Ecount +=1
			if(Ecount>99):
				Ecount = 0
			Ereload = 8
	Ereload -= int(Ereload !=0 )
	var rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
		pressed += 0.01*(int(pressed<4)*2-1)
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
		pressed += 0.01*(int(pressed<4)*2-1)
	if !(Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		pressed = 1

	#gravity
	applied_force += PublicFuncs.Grav(position,mass,self)
	
	
	#torque contraption
	groundmult=1
	if(torquetimer==0):
		torquetimer = 60
		Closest()
	torquetimer-=1
	if (Vector2(Planethost.linear_velocity-linear_velocity).length()<200):
		groundmult = 1+applied_force.length()/200
	
	applied_torque = rotation_dir * torque *groundmult #* pressed
	
	var zoom = $Ship/Camera2D.zoom
	var zoomif = (int(Input.is_action_pressed("ui_minus"))*int(zoom[0]<30)-int(Input.is_action_pressed("ui_plus"))*int(zoom[0]>0.6))*zoom[0]*0.02
	$Ship/Camera2D.zoom += Vector2(zoomif,zoomif)
	$Ship/Camera2D/YSort/Background.scale = $Ship/Camera2D.zoom
	$Ship/Camera2D/YSort/Background.rotation = -rotation
	$Ship/Camera2D/YSort/Background.position = -position.rotated(-rotation)*0.05

