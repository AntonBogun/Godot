extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var throttle
var leng=128
var off=64
var colormin=vertex_colors[0]
var colormax=vertex_colors[3]
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	throttle = float(get_node("../../../..").infoparent.throttle)
	for i in range(2,4):
		polygon[i].y=off-leng*(throttle/180)
		vertex_colors[i]=lerp(colormin,colormax,throttle/180)
		
		#add 
	
