extends Polygon2D



# NEED TO ADD UN-STACK ALGORITHM

var cull = false
var rngseed
var stars=Array()
var Delay=PublicFuncs.newList()
var online = true
var staramount=120
var rng
var test = true
var minlen = 1000
var polysize = polygon
var xrange = polysize[0][0]-polysize[1][0]
var yrange = polysize[2][1]-polysize[1][1]
var Checkarray= Array()
func _ready():
	var rngsetup = RandomNumberGenerator.new()
	rngsetup.randomize()
	rngseed=round(rngsetup.randf()*100)
	rng = RandomNumberGenerator.new()
	for _y in 6:
		var yarray=Array()
		for _x in 11:
			var xarray=Array()
			yarray.append(xarray)
#			 checkarray.append(Vector2(xrange/10*(_x)-polysize[0][0],yrange/5*(_y)-polysize[2][1]))
		Checkarray.append(yarray)

var displace = Vector2(1000,1000)
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
			var x=rng.randi_range(polysize[1][0],polysize[0][0])
			var y=rng.randi_range(polysize[1][1],polysize[2][1])
			var xsect = round(x/xrange*10)
			var ysect= round(y/yrange*10)
			
			var size=rng.randi_range(1,14)
			
			
			var color = rng.randf()
			var rgb
			var which = color*10
			if which<5:
				rgb = Color(1,1,1)
			elif which <7.5:
				rgb = Color(1,0.7*((color-0.5)+0.15)*10/4,0)
			else:
				rgb = Color(0,0.8*((color-0.75)*2+0.5),1)
			
			if size <7:
				size=size/2+3.5
				rgb = Color(rng.randf(),rng.randf(),rng.randf())
				var rgb1=1-max(rgb[0],max(rgb[1],rgb[2]))
				rgb=Color(rgb[0]+rgb1,rgb[1]+rgb1,rgb[2]+rgb1)
				
			var bad = false
			#need to add neighbour sector check but fuck it for now
			for i1 in Checkarray[ysect][xsect]:
					if Vector2(x-i1[0],y-i1[1]).length()*2<(size+i1[2]):
						bad = true
						break
			if bad:
				continue
			else:
				Checkarray[ysect][xsect].append([x,y,size])
#			185 green, red
#			0-200green,blu
#			third white
# current algorithm, almost realistic but also extremely dumb in the end

			
#			var white = min(min(rgb[0],rgb[0]),rgb[0])>0.6
#			rgb[1]=(rgb[1]-0.6)*int((rgb[1]-0.6)>0)
#			var b = 0.2
#			rgb[2]=(rgb[2]-b)*int((rgb[2]-b)>0)
#			
#previous algorithm, colorful but too complicated for what its worth

			stars.append([x,y,size/2,rgb])
		update()
		online=false
