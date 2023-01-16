extends KinematicBody2D


var velocity := Vector2(0,0)
var lifetime: float = 2.0

onready var life_start = OS.get_ticks_msec()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	if OS.get_ticks_msec() - life_start > lifetime*1000:
		queue_free()
# warning-ignore:return_value_discarded
	move_and_slide(velocity)
