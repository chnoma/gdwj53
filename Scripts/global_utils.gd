extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func normalized_spread(direction: Vector2, spread_coefficient: float):
	return (direction+Vector2(GlobalMaster.rng.randf_range(-spread_coefficient, spread_coefficient),
			GlobalMaster.rng.randf_range(-spread_coefficient, spread_coefficient))).normalized()
