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

func newList():
	var list = [0]
	for i in 10:
		list+=list
	return list

#decrement by 1 unless ==0
func Delay(list,id):
	list[id]-=int(list[id]>0)

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
