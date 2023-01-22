extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var base_scale := 1.0
export var period := 200.0
export var percent := 0.3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	scale = Vector2(base_scale,base_scale)*abs(sin(OS.get_ticks_msec()/period)*percent+(1-percent))
