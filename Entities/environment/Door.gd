extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_left_zone_area_entered(area):
	if !open:
		$Node2D/Door/solid/CollisionShape2D.set_deferred("disabled", true)
		$sfx_open.play()
		$AnimationPlayer.play("open_right")
		open = true


func _on_right_zone_area_entered(area):
	if !open:
		$Node2D/Door/solid/CollisionShape2D.set_deferred("disabled", true)
		$sfx_open.play()
		$AnimationPlayer.play("open_left")
		open = true
