extends KinematicBody2D


var velocity := Vector2(0,0)
var lifetime: float = 2.0
var damage = 3
onready var life_start = OS.get_ticks_msec()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	if OS.get_ticks_msec() - life_start > lifetime*1000:
		die()
# warning-ignore:return_value_discarded
	move_and_slide(velocity)

func _on_BulletArea_area_entered(area):
	if area.get_parent() is BaseEnemy:
		area.get_parent().damage(damage)
		die()

func die():
	queue_free()
