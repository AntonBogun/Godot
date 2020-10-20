extends Camera2D



#var UI
#var UIOffset = Array()

func _ready():
#	UI = get_tree().get_nodes_in_group("UI")
#	for obj in UI:
#		UIOffset.append(PublicFuncs.GetPos(obj))
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$Node2D.rotation = -global_rotation
	$Node2D.scale=zoom
#	var i = 0
#	for obj in UI:
#		print(PublicFuncs.GlobalPos(self))
#		PublicFuncs.Center(obj,PublicFuncs.GlobalPos(self)+UIOffset[i])
#		PublicFuncs.Rescale(obj,zoom)
# I HATE TRANSFORMS AND I WANT TO NEVER TOUCH THEM AGAIN
