extends Line2D


var init = true
var online = false
var line = Array()
var mass = 1
var deactivate = false
# Called when the node enters the scene tree for the first time.
func _ready(): # Replace with function body.
	pass

#asdaidpiaspdi INSTANCE

func _process(delta):
	if(online):
		if deactivate:
			queue_free()
		if (init):
			width=pow(log(mass),0.5)*10+10
			points=line
			visible=true
		init = false