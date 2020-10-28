extends Node

func HexToInt (hx):
	var hex=StringInvert(str(hx).to_upper())
	var final = 0
	var i=0
	for cha in hex:
		match cha:
			"1","2","3","4","5","6","7","8","9","0":
				final+=int(cha)*pow(16,i)
			"A","B","C","D","E","F":
				final+=(ord(cha)-55)*pow(16,i)
			_:
				return 0
		i+=1
	return final

func HexToColor(C):
	var Col = str(C).to_upper()
	var color = Array()
	if Col.length()!=6:
		return Color()
	for i in range(3):
		var clor=str(Col[i*2],Col[i*2+1])
		color.append(HexToInt(clor))
	return Color8(color[0],color[1],color[2])

func CircleStep(s,m=1,a=0):
	var step = float(s)
	var mult=float(m)
	var add=float(a)
	var array = Array()
	for i in range(step):
		var ang=float(i/step*PI*2+a)
		array.append(Vector2(sin(ang)*mult,cos(ang)*mult))
	return array


func StringInvert(string):
	var s=str(string)
	var temp = "a"
	var l = s.length()-1
	for i in range(floor(s.length()/2)):
		temp=string[i]
		string[i]=string[l]
		string[l]=temp
		l-=1
	return string

func NewList():
	var list = [0]
	for i in 5:
		list+=list
	return list

#decrement by 1 unless ==0
func Delay(v):
	v-=int(v>0)
	return v

	pass
func _ready():
	pass # Replace with function body.


func Center(_Node,_pos):
	if _Node is Control:
		_Node.rect_position=_pos
	else:
		_Node.position=_pos

func Rotate(_Node,_angle):
	_Node.rotation = -_angle

func Rescale(_Node,_scale):
	
	if _Node is Control:
		_Node.rect_scale=_scale
	else:
		_Node.scale=_scale

func GlobalPos(obj):
	return obj.get_global_transform()[2]

#i want to never touch this idiocy ever again
func GetPos(_Node):
	if _Node is Control:
		return _Node.rect_position
	else:
		return _Node.position
#func bruh():
#	for Planet in get_tree().get_nodes_in_group("GravObj"):
#			print(Planet.Gravid)
#
#		#id != null and id != planet

func CustomRound(num,custom):
	return round(num*pow(10,custom))/pow(10,custom)

func Grav(Globalpos,mass,id=null):
	var Grav = Vector2()
	for Planet in get_tree().get_nodes_in_group("GravObj"):
		if (id!=Planet):
			var direct = Vector2(Planet.position[0],Planet.position[1])
			var directfull = direct + Vector2(-Globalpos[0],-Globalpos[1])
			var streng = Planet.mass/pow(directfull.length(),2)*100000*mass
			Grav += Vector2(directfull[0]/directfull.length()*streng,directfull[1]/directfull.length()*streng)
	return Grav

func ArrayFill(k1,fill=null):
	var k=int(k1)
	var array=Array()
	for i in range(k):
		array.append(fill)
	return array
func ArrayArrayFill(k3,k2,fill=null):
	var k = int(k3)
	var k1=int(k2)
	var array = Array()
	for i in range(k):
		array.append(Array())
		for i1 in range (k1):
			array[i].append(fill)
	return array

func ParentFind(type,me):
	var node =me
	while(!node is RigidBody2D):
		node=node.get_parent()
	return node

func ArrayOverflow(N,L):
	var n = int(N)
	var l = int(L)
	if n<0:
		n = abs(n)
		n= n%l
		n= l-n
	else:
		n=n%l
	return n

func ApplyGrav(m,pos,area,parent=null,resetarray=Array(),gravdescribe = false):
	var mass = float(m)
	if (!(pos is Vector2) or !(area is Area2D)):
		return
	if !(parent == null):
		if resetarray!=Array():
			for obj in resetarray:
				if is_instance_valid(obj[0]):
					obj[0].applied_force+=obj[1]
		var array = Array()
		for obj in area.get_overlapping_bodies():
			if obj is RigidBody2D and obj!=parent:
				var diffpos=-obj.global_position+pos
				var force = obj.mass/pow(diffpos.length(),2)*100000*mass
				obj.applied_force+=force*diffpos.normalized()
				array.append([obj,-force*diffpos.normalized()])
				#for closest() to work
				if "gravarray" in obj and gravdescribe:
					
					obj.gravarray.append(parent)
		return array


func FitNumber(n,leng,minzer=-1):
	minzer=max(-1,minzer)
	var minzero=(leng-str(floor(n)).length())*int(minzer==-1)+(minzer)*int(minzer!=-1)
	if str(n).length()<leng:
		minzero=str(n).length()-str(floor(n)).length()
	var e=str(floor(n)).length()
	if leng>=e:
		if str(n).length()>leng and minzer==-1:
			#minzer not defined, n larger than leng
			return ("%0."+str(leng-e-1*int(leng!=e))+"f")%n
		elif minzer==-1:
			#minzer not defined, n smaller than leng
			return ("%0."+str(minzero-1)+"f")%n
		else:
			#minzer defined
			return ("%0."+str(min(minzer,leng-str(floor(n)).length()-1) )+"f")%n
	var E = str(e-1).length()+2
	var n2=n/pow(10,e-1)
	var final = str((("%0."+str(max(leng-E-1,0))+"f")%n2)+"E"+str(e-1))
	if minzero>=0:
		return ("%0."+str(int(minzero))+"f")%n
	else:
		return final
#this is dark magic, dont even try to understand.


func FindClosest(objarray,pos):
	var closest
	var closestist
	if objarray==Array():
		return null
	for obj in objarray:
		if closestist==null:
			closestist=(obj.global_position-pos).length()
			closest=obj
			continue
		if closestist>(obj.global_position-pos).length():
			closestist=(obj.global_position-pos).length()
			closest=obj
	return closest
