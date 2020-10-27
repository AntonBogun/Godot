extends Camera2D



#var UI
#var UIOffset = Array()
var Delay
var Hold
var zoomfix
var parent
func _ready():
	Delay=PublicFuncs.NewList()
#	UI = get_tree().get_nodes_in_group("UI")
#	for obj in UI:
#		UIOffset.append(PublicFuncs.GetPos(obj))
	
	#print(get_viewport().size)
	zoomfix = Vector2(get_viewport().size.x/1536,get_viewport().size.y/864)*1.25
	zoom = zoom*zoomfix
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var zoomif = (int(Input.is_action_pressed("ui_minus"))*int(zoom[0]*zoomfix[0]<500)-int(Input.is_action_pressed("ui_plus"))*int(zoom[0]*zoomfix[0]>1))*zoom[0]*0.02*zoomfix[0]
	zoom += Vector2(zoomif,zoomif)
	
	rotation = -get_parent().global_rotation
	$Background.scale=zoom
	$UI.scale=zoom
	
	Delay[0]=PublicFuncs.Delay(Delay[0])
	if Delay[0]==0 && Input.is_action_pressed("ui_F2")&&!Hold:
		Delay[0]=5
		$UI.visible=!$UI.visible
		Hold = true
	if !Input.is_action_pressed("ui_F2"):
		Hold = false
	
#old shit that was left from the moving background and when camera script was on the ship.
#	get_node("../ParallaxBackground/Stars/Node2D")
#	get_node("../ParallaxBackground").scale = $Camera2D.zoom
#	get_node("../ParallaxBackground/Stars/Node2D").position=Vector2(1920,1080)*($Camera2D.zoom[0]-1)*-0.40*get_viewport().size[0]/1536
#	get_node("ActualView").rotation= -rotation

#	var i = 0
#	for obj in UI:
#		print(PublicFuncs.GlobalPos(self))
#		PublicFuncs.Center(obj,PublicFuncs.GlobalPos(self)+UIOffset[i])
#		PublicFuncs.Rescale(obj,zoom)
# I HATE TRANSFORMS AND I WANT TO NEVER TOUCH THEM AGAIN
#ok retard from the past, transforms are love, transforms are life (if you do them right)
