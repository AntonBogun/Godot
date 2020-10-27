extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var init = true
var online = false
var speed = 500
var time = 0
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready(): # Replace with function body.
  rng.randomize()



func _process(delta):
	if(online):
		var angle = get_node("..").rotation
		var parentpos = get_node("..").position
		var globalpos = position.rotated(angle)+parentpos
		applied_force = PublicFuncs.Grav(globalpos,mass)
		
		$CollisionShape2D/Node2D.color -= Color(0.004/2.5,0.008/2.5,0,0)
		$CollisionShape2D.scale += Vector2(0.15/5,0.15/5)
		time+=1
#   if($CollisionShape2D/Polygon2D.color[1] != 0):
##      $CollisionShape2D/Polygon2D.color -= Color(1,2,0,0)
#   el
		if(time==600):
			queue_free()
		if (init):
			var rotat = get_node("..").rotation
			linear_velocity = get_node("..").linear_velocity-Vector2(speed*cos(rotat-PI/2),speed*sin(rotat-PI/2))+Vector2(rng.randf_range(-300,300),rng.randf_range(-300,300))
			position = Vector2(0,50)
			$CollisionShape2D.disabled = false
			visible = true
			init = false

