extends Node

func remove_object(object):
	object.queue_free()

func draw_tracer(origin, endpoint, color, lifetime):
	var tracer = Line2D.new()
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

func spark(count, position, spread):
	for i in count:
		var rand = Vector2(GlobalMaster.rng.randf_range(-spread,spread),
							   GlobalMaster.rng.randf_range(-spread,spread))
		draw_tracer(position, position+rand, Color(255,255,255), 
								 GlobalMaster.rng.randf_range(0.01, 0.05))
