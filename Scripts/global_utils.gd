extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func raycast(origin, endpoint, bitmask):
	var space_state = get_tree().get_root().get_node("MainView").get_world_2d().direct_space_state
	var result = space_state.intersect_ray(origin, 
		endpoint, [],
		bitmask, true, true)
	return result
