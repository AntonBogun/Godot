extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Delay
var Hold = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Delay=PublicFuncs.NewList()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	PublicFuncs.Delay(Delay[0])
	if Delay[0]==0 && Input.is_action_pressed("ui_F1")&&!Hold:
		Delay[0]=5
		visible=!visible
		Hold = true
	if !Input.is_action_pressed("ui_F1"):
		Hold = false

