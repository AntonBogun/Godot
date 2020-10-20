extends Label

var accum = 0
var accum1 = 0
var toggle = 0
func _ready():
	get_node("../Button").connect("pressed", self, "_on_Button_pressed")
	 # Replace with function body.
#func _on_Button_pressed():
#	toggle %= 2
#	toggle += 1
#func _process(delta):
#	accum += delta
#	accum1 = floor(10*accum)/10
#	if(toggle==1):
#		text = str(accum1)
#	else:
#		text = "Toggle" # 'text' is a built-in label property.
func _physics_process(delta):
#	text = str(PublicFuncs.CustomRound(get_parent().get_parent().applied_force.length(),2))
	pass
