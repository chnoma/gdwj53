extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	scale = Vector2(1,1)*abs(sin(OS.get_ticks_msec()/400.0)*0.2+0.8)
