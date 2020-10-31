extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skip = 10
var Delay
var Hold
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
var tick = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	SimObj = get_tree().get_nodes_in_group("SimObj")
	Delay=PublicFuncs.NewList()
	Hold=PublicFuncs.NewList()

func state():
	list.clear()
	if(state.size()<SimObj.size()):
		for _i in range(SimObj.size()-state.size()):
			state.append(null)
			#make sure array is long enough
	var i = 0
	for Obj in SimObj:
		if Obj.is_in_group("GravObj"):
			state[i]=[Obj.global_position,Obj.linear_velocity,Array(),Obj.mass,true,Obj.gravradius*1.25]
		else:
			state[i]=[Obj.global_position,Obj.linear_velocity,Array(),Obj.mass,false]
		i+=1
	for obj1 in state:
		var soi=Array()
		var i1 = 0
		for obj2 in state:
			if obj2[4]:
				
				if (obj1[0]-obj2[0]).length()<obj2[5]:
					soi.append(i1)
				i1+=1
		obj1[2]=soi
	list.append(state)
#0-position,1-velocity,2-mass,3-precise SOI array,4-grav?,5-grav radius

func precisionsoi(pos,posarray):
	var soi=Array()
	var i1 = 0
	for obj2 in state:
		if obj2[4]:
			if (pos-posarray[i1][0]).length()<obj2[5]:
				soi.append(i1)
			i1+=1
	return soi


func addtick(tick):
	#start of tick
	var tempstate = Array()
	var i = 0
	
	if tick%60==0:
		for obj in list[list.size()-1]:
			obj[2]=precisionsoi(obj[0],list[list.size()-1])
	if list.size()>2:
		for obj in list[list.size()-2]:
			obj=obj[0]
	#avoid death
	for Obj in list[list.size()-1]:
		#line segment addition
		
		var Grav = Vector2()
		
		for id in Obj[2]:
			var GravObj=list[list.size()-1][id]
			if (state[id][4] and i!=id):
				if (Obj[0]-GravObj[0]).length()<state[id][5]:
					var pos = GravObj[0] - Obj[0]
					var streng = state[id][3]/pow(pos.length(),2)*100000*state[i][3]
					Grav += Vector2(pos[0]/pos.length()*streng,pos[1]/pos.length()*streng)/state[i][3]*timescale
				
		tempstate.append([Obj[0]+Obj[1]*timescale+Grav*timescale,Obj[1]+Grav,Obj[2]])
		i+=1
		
	list.append(tempstate)
	#end of tick
	

func DRAW():
	#PLEASE MAKE IT NOT FUCK ITSELF WHEN THE AMOUNT OF SIMOBJS DECREASES LATER ON (idk i think its solved but uiaoduqiu) #dude i dont care lmao
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
		call_deferred("add_child", Lines[templine])#NOTE: CHANGE TO INSTANCE BCAUSE AAAAAAAAA #-u dum, its already instanced (duplication is smort)
		var line = Array()
		var i = 0
		for tick in list:
			
			line.append(list[i][templine][0])
			if (i+skip>list.size()-1):
				break
			i=min(list.size()-1,i+skip)
		Lines[templine].line=line
		Lines[templine].mass=state[templine][3]
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
					addtick(Delay[0])
					Delay[0]=PublicFuncs.Delay(Delay[0])+int(Delay[0]==0)*59
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
	
#	Delay[0]=PublicFuncs.Delay(Delay[0])
#	if Delay[0]==0 && Input.is_action_pressed("ui_f")&&!Hold[0]==0:
#		Delay[0]=6
#		renew=true
#		Hold[0] = 1
#	if !Input.is_action_pressed("ui_f"):
#		Hold[0] = 0
