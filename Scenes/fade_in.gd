extends Node


export var fade_in_time: float = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("fade")
	

func fade():
	GlobalViewport.fade_to_black.fade(fade_in_time, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
