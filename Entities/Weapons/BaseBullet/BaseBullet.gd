extends Area2D

enum bullet_type {PLAYER, ENEMY}

var velocity := Vector2(0,0)
var lifetime: float = 2.0
var damage = 3
var life_start = OS.get_ticks_msec()

export(bullet_type) var type = bullet_type.PLAYER

# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(position+velocity)


func _process(delta):
	if OS.get_ticks_msec() - life_start > lifetime*1000:
		die()
# warning-ignore:return_value_discarded
	position+=velocity*delta

#func _on_BulletArea_area_entered(area):
#	if area.get_parent() is BaseEnemy:
#		area.get_parent().damage(damage)
#		die()

func die():
	queue_free()
