extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var finished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if !finished:
		position -= Vector2(0,100)*delta
		if $Node2D.global_position.y < 0:
			finished = true
