extends Node

var BLOOD_SURFACE_SIZE = Vector2(128, -128)
var BLOOD_MAX_LIFE = 2
var BLOOD_SPRAY_MAX_PARTICLES = 40
var BLOOD_SPRAY_SPREAD = 0.4
var BLOOD_SPRAY_SPEED = 250

var blood_controller = null

func remove_object(object):
	object.queue_free()

func draw_tracer(origin, endpoint, color, lifetime):
	var tracer = Line2D.new()
	tracer.z_index = 444
	tracer.z_as_relative = false
	tracer.default_color = color
	tracer.add_point(origin)
	tracer.add_point(endpoint)
	tracer.width = 1
	GlobalViewport.viewport.add_child(tracer)
	var killtimer = Timer.new()
	killtimer.connect("timeout", self, "remove_object", [tracer])
	killtimer.wait_time = lifetime
	killtimer.one_shot = true
	GlobalViewport.viewport.add_child(killtimer)
	killtimer.start()

func draw_rect(rect: Rect2, color, lifetime):
	draw_tracer(rect.position, rect.position+Vector2(rect.size.x,0), color, lifetime)
	draw_tracer(rect.position+Vector2(rect.size.x,0), rect.position+rect.size, color, lifetime)
	draw_tracer(rect.position+rect.size, rect.position+Vector2(0,rect.size.y), color, lifetime)
	draw_tracer(rect.position+Vector2(0,rect.size.y), rect.position, color, lifetime)

func spark(count, position, spread):
	for i in count:
		var rand = Vector2(GlobalMaster.rng.randf_range(-spread,spread),
							   GlobalMaster.rng.randf_range(-spread,spread))
		draw_tracer(position, position+rand, Color(255,255,255), 
								 GlobalMaster.rng.randf_range(0.01, 0.05))
