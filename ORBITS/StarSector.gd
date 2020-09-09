extends Node2D



# NEED TO ADD UN-STACK ALGORITHM


var cull = false
var rngseed = 0
var stars=Array()
var Delay=PublicFuncs.newList()
var online = false
var staramount=25
var rng
var test = true
func _ready():
	rng = RandomNumberGenerator.new()

func _draw():
	for star in stars:
		draw_circle(Vector2(star[0],star[1]),star[2],star[3])
#		draw_polygon(Vector2(star[0],star[1]),star[2],Color(1,1,1))
		pass

func _physics_process(delta):
	if cull:
			queue_free()
	if online:
		rng.set_seed(rngseed)
		for i in staramount:
			var x=rng.randi_range(-500,500)
			var y=rng.randi_range(-500,500)
			var size=rng.randi_range(1,10)
			var color = rng.randf()
			var rgb
			var which = floor(color*10)
			if which<7:
				rgb = Color(1,1,1)
			elif which <8.5:
				rgb = Color(1,0.7*color,0)
			else:
				rgb = Color(0,0.8*color,1)
#			185 green, red
#			0-200green,blu
#			third white
# current algorithm, almost realistic but also extremely dumb in the end

#			var rgb = Color(rng.randf(),rng.randf(),rng.randf())
#			var white = min(min(rgb[0],rgb[0]),rgb[0])>0.6
#			rgb[1]=(rgb[1]-0.6)*int((rgb[1]-0.6)>0)
#			var b = 0.2
#			rgb[2]=(rgb[2]-b)*int((rgb[2]-b)>0)
#			var rgb1=1-max(rgb[0],max(rgb[1],rgb[2]))
#			rgb=Color(rgb[0]+rgb1,rgb[1]+rgb1,rgb[2]+rgb1)
#previous algorithm, colorful but too complicated for what its worth

			stars.append([x,y,size,rgb])
		update()
		online=false
