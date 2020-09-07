extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skip = 10

var delay = 0
var toggledelay=0
var DRAWdelay = 0
var state = Array()
var list = Array()
var SimObj
var toggle = false
var timescale = 0.016667
var Lines = [null]
var templine = 0
var ConstantUpdate=false
var tempconstant=0
var tempupdate=0
# Called when the node enters the scene tree for the first time.
func _ready():
	SimObj = get_tree().get_nodes_in_group("SimObj")

func state():
	list.clear()
	if(state.size()<SimObj.size()):
		for _i in range(SimObj.size()-state.size()):
			state.append(null)
	var i = 0
	for Obj in SimObj:
		state[i]=[Obj.position,Obj.linear_velocity,Obj.mass,Obj.is_in_group("GravObj"),]
		i+=1
	list.append(state)



func addtick():
	#start of tick
	var tempstate = Array()
	var i = 0
	for Obj in list[list.size()-1]:
		#line segment addition
		
		var Grav = Vector2()
		var i1 = 0
		for GravObj in list[list.size()-1]:
			if (state[i1][3] and i!=i1):
				var pos = GravObj[0] - Obj[0]
				var streng = state[i1][2]/pow(pos.length(),2)*100000*state[i][2]
				Grav += Vector2(pos[0]/pos.length()*streng,pos[1]/pos.length()*streng)/state[i][2]*timescale
				
			i1+=1
		tempstate.append([Obj[0]+Obj[1]*timescale+Grav*timescale,Obj[1]+Grav])
		i+=1
		
	list.append(tempstate)
	#end of tick
	

func DRAW():
	#PLEASE MAKE IT NOT FUCK ITSELF WHEN THE AMOUNT OF SIMOBJS DECREASES LATER ON (idk i think its solved but uiaoduqiu)
	templine=0
	if	Lines[0]!=null:
		for trail in Lines:
			if trail!=null:
				trail.deactivate=true
				trail=null
	for a in SimObj:
		
		if Lines.size()<SimObj.size()+1:
			Lines.append(null)
		Lines[templine]=$Trail.duplicate()
		call_deferred("add_child", Lines[templine])#NOTE: CHANGE TO INSTANCE BCAUSE AAAAAAAAA
		var line = Array()
		var i = 0
		for tick in list:
			
			line.append(list[i][templine][0])
			if (i+skip>list.size()-1):
				break
			i=min(list.size()-1,i+skip)
		Lines[templine].line=line
		Lines[templine].mass=state[templine][2]
		Lines[templine].online=true
		templine+=1
func _draw():
#	var i = 0
#	for tick in list:
#		var i1 = 0
#		for Obj in list[i]:
#			if(i!=0):
#				draw_line(list[i-1][i1][0],Obj[0],Color(128, 153, 255),log(list[0][i1][2])*5)
#			i1+=1
#		i=min(list.size()-1,i+10)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# warning-ignore:unused_argument
func _physics_process(delta):
	if (Input.is_action_pressed("ui_r")and !bool(delay))or (ConstantUpdate and !bool(tempupdate)):
		delay = 20
		state()
		if	Lines[0]!=null:
			for trail in Lines:
				if trail!=null:
					trail.deactivate=true
					trail=null
		tempupdate=180
	elif(toggle):
		if(!list.empty()):
			if list.size()<30000:
				for i in 10:
					addtick()
			if(!bool(DRAWdelay)):
				DRAW()                # INSTANCE BRUH MOMENT
				DRAWdelay=10
			DRAWdelay-=int(DRAWdelay>0)
		else: 
			state()
			delay = 10
	if Input.is_action_pressed("ui_m")and !bool(toggledelay):
		toggle=!toggle
		toggledelay = 25
	delay += -int(delay>0)
	toggledelay += -int(toggledelay>0)
	if Input.is_action_pressed("ui_t")and !bool(tempconstant):
		ConstantUpdate = !ConstantUpdate
		tempconstant=10
	tempconstant-= int(tempconstant>0)
	tempupdate-=int(tempupdate>0)
