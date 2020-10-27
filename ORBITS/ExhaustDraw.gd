extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var colr="fffe00"
var color = PublicFuncs.HexToColor(colr)
var poly = PublicFuncs.CircleStep(16,13.5)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _draw():
	draw_polygon(poly,PublicFuncs.ArrayFill(16,color))

func _process(delta):
	update()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
