extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var amount = 60
export var every = 9
export var size = 72
export var ratio = 0.9
export var color = Color(1,1,1)
export var arrow=[Vector2(0,-72),Vector2(5,-67),Vector2(-5,-67)]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var array = PublicFuncs.CircleStep(amount,size)
	var polys= PublicFuncs.ArrayArrayFill(amount/every,4,Vector2())
	for k in range(amount/every-1):
		var i = k-amount/every/2+1
		polys[i][0]=array[PublicFuncs.ArrayOverflow(i*every-1,array.size())]
		polys[i][1]=array[PublicFuncs.ArrayOverflow(i*every+1,array.size())]
		polys[i][2]=array[PublicFuncs.ArrayOverflow(i*every+1,array.size())]*ratio
		polys[i][3]=array[PublicFuncs.ArrayOverflow(i*every-1,array.size())]*ratio
	for arr in polys:
		draw_polygon(arr,PublicFuncs.ArrayFill(4,color))
	
	draw_polygon(arrow,PublicFuncs.ArrayFill(3,color))
func _physics_process(delta):
	rotation = get_node("../../../../..").global_rotation
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
