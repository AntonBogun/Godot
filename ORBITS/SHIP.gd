extends RigidBody2D



export var thrust = Vector2(0, -750)
export var torque = 3000

var gravarray=Array()
var Exhaust = Array()
var Ereload = 0
var Ecount = 0
var pressed = 1
var groundmult =1
var torquetimer=0
var planetparent
var Planethost

var previousforce=Vector2()
var externalforce=Vector2()

var Delay
var Hold
var ThrustMode = 0
var ToggleMode=0
var throttle=180
var ttime=180 #throttletime
var force=Vector2()


func _ready():
	$Camera2D.infoparent = self
	Delay=PublicFuncs.NewList()
	Hold=PublicFuncs.NewList()
#	print_tree_pretty()

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
	force=Vector2()
	# thrust and turning
	Delay[0]=PublicFuncs.Delay(Delay[0])
	if Delay[0]==0 && Input.is_action_pressed("ui_q")&&Hold[0]==0:
		Delay[0]=6
		ThrustMode= 1-ThrustMode
		ToggleMode=0
		Hold[0] = 1
	if !Input.is_action_pressed("ui_q"):
		Hold[0] = 0
	
	Delay[1]=PublicFuncs.Delay(Delay[1])
	if Delay[1]==0 && Input.is_action_pressed("ui_up")&&Hold[1]==0&&ThrustMode==1:
		Delay[1]=6
		ToggleMode=1-ToggleMode
		Hold[1] = 1
	if !Input.is_action_pressed("ui_up")&&ThrustMode==1:
		Hold[1] = 0
	throttle+=(int(Input.is_action_pressed("ui_shift"))*int(throttle<ttime)-int(Input.is_action_pressed("ui_ctrl"))*int(throttle>0))
	
	if (Input.is_action_pressed("ui_z")||Input.is_action_pressed("ui_x"))&&!(Input.is_action_pressed("ui_z")&&Input.is_action_pressed("ui_x")):
		throttle=ttime*int(Input.is_action_pressed("ui_z"))
	
	externalforce=applied_force-previousforce
	#print(applied_force)
	applied_force = Vector2()
	if Input.is_action_pressed("ui_up")||(ThrustMode==1&&ToggleMode==1):
		applied_force += thrust.rotated(rotation)*throttle/ttime
		force=thrust.rotated(rotation)*throttle/ttime
		if (Ereload == 0)&&throttle!=0:
			if Ecount<100:
				Exhaust.append(null)
			#asdqwdoiaposd make it using scene instancing
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
	#applied_force += PublicFuncs.Grav(position,mass,self)
	
	
	#torque contraption
	
	applied_torque = rotation_dir * torque *groundmult #* pressed
	previousforce=applied_force
	applied_force+=externalforce
	groundmult=1
	if planetparent!=null:
		#contains force calc, so goes after externalforce
		if (Vector2(planetparent.linear_velocity-linear_velocity).length()<100):
			groundmult = (1+(applied_force+force).length()/80)
	if gravarray!=Array():
		$Camera2D.parent=PublicFuncs.FindClosest(gravarray,global_position)
		planetparent=$Camera2D.parent
	gravarray=Array()
	




