class_name Fader
extends Sprite

var alpha: float = 0.0

var fading = false
var fade_time: float = 0.0
var fade_from = false

# Called when the node enters the scene tree for the first time.
func _ready():
	material = material.duplicate()

func _process(delta):
	# some weirdness going on here - keep for later effect
	# setalpha(abs(sin(OS.get_ticks_msec()/500.0)))
	if fading:
		if fade_from:
			setalpha(alpha-(delta/fade_time))
		else:
			setalpha(alpha+(delta/fade_time))
		if alpha > 1 || alpha < 0:
			fading = false

func fade(time, ff=false):
	if ff:
		setalpha(1)
	else:
		setalpha(0)
	fade_time = time
	fade_from = ff
	fading = true
	

func setalpha(a):
	alpha = a
	material.set_shader_param("alpha", min(max(alpha,0),1) )

func getalpha():
	return alpha
