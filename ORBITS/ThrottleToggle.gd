extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var size = 7
var colors = ["2b2b2b","00ff50","003611","00f6ff","004042"]
var mode
var force
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	if get_node("../../../..").infoparent!=null:
		if get_node("../../../..").infoparent.force!=null:
			mode = get_node("../../../..").infoparent.ThrustMode
			force = get_node("../../../..").infoparent.force.length()==0
			var clor=int(force)+mode*2+1
			draw_circle(Vector2(),size,PublicFuncs.HexToColor(colors[clor]))
	else:
		draw_circle(Vector2(),size,PublicFuncs.HexToColor(colors[0]))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
